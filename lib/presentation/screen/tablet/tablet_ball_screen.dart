import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shake/shake.dart';
import 'package:surf_practice_magic_ball/common/app_color.dart';
import 'package:surf_practice_magic_ball/presentation/provider/magic_state_provider.dart';
import 'package:surf_practice_magic_ball/utils/core/delayed.dart';

import '../../../utils/core/logging.dart';
import '../../../utils/core/scale_size.dart';
import '../../provider/magic_manager.dart';
import '../../provider/magic_notifer_provider.dart';
import '../../widgets/tablet/tablet_bottom_text_widget.dart';

final Logging log = Logging('TabletBallScreen');

class TabletBallScreen extends ConsumerStatefulWidget {
  const TabletBallScreen({super.key});

  @override
  ConsumerState<TabletBallScreen> createState() => _MagicBallScreenState();
}

class _MagicBallScreenState extends ConsumerState<TabletBallScreen> {
  late Color color;

  getMagic() {
    ref.watch(magicManagerProvider).getMagic();
  }

  @override
  void initState() {
    super.initState();
    ShakeDetector detector = ShakeDetector.waitForStart(
      onPhoneShake: () {
        log.debug('Shake');
        getMagic();
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );
    detector.startListening();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log.debug('Screen');
    final state = ref.watch(magicStateProvider);
    final width = MediaQuery.of(context).size.width;
    log.debug('State: ${state.toString()}');
    final message = ref.read(magicNotiferProvider);
    switch (state) {
      case MagicState.error:
        color = AppColor.error.withOpacity(1.0);
        break;
      case MagicState.wait:
        color = AppColor.dark.withOpacity(1.0);
        delayed();
        break;
      case MagicState.result:
        color = AppColor.dark.withOpacity(1.0);
        break;
      default:
        color = AppColor.dark.withOpacity(0.0);
    }
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColor.linearBegin,
                    AppColor.linearEnd,
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastOutSlowIn,
                          padding:
                              const EdgeInsets.only(left: 14.5, right: 14.5),
                          child: GestureDetector(
                            onTap: () {
                              log.debug('Tap ball');
                              getMagic();
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  width: width - 200,
                                  fit: BoxFit.cover,
                                  'assets/images/Ball.png',
                                ),
                                Image.asset(
                                  fit: BoxFit.cover,
                                  'assets/images/Vector.png',
                                  width: width - 200,
                                  color: color,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(50.0),
                                  child: Text(
                                    message ?? '',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontFamily: 'Gill Sans',
                                      color: Colors.white,
                                      fontSize: 36.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textScaleFactor:
                                        ScaleSize.textScaleFactor(context),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Image.asset(
                          fit: BoxFit.cover,
                          'assets/images/Ellipse.png',
                          width: width - 400,
                          // color: color,
                        ),
                      ],
                    ),
                  ),
                  const TabletBottomTextWidget()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
