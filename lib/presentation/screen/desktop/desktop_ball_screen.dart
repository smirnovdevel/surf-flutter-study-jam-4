import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shake/shake.dart';
import 'package:surf_practice_magic_ball/common/app_color.dart';
import 'package:surf_practice_magic_ball/presentation/provider/magic_state_provider.dart';
import 'package:surf_practice_magic_ball/utils/core/delayed.dart';

import '../../../utils/core/logging.dart';
import '../../provider/magic_manager.dart';
import '../../provider/magic_notifer_provider.dart';
import '../../widgets/desktop/desktop_bottom_text_widget.dart';

final Logging log = Logging('MagicBallScreen');

class DesktopBallScreen extends ConsumerStatefulWidget {
  const DesktopBallScreen({super.key});

  @override
  ConsumerState<DesktopBallScreen> createState() => _MagicBallScreenState();
}

class _MagicBallScreenState extends ConsumerState<DesktopBallScreen> {
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
    final state = ref.watch(magicStateProvider);
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
      body: SafeArea(
        top: false,
        left: false,
        right: false,
        bottom: false,
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
                    const SizedBox(
                      height: 85.0,
                    ),
                    AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastOutSlowIn,
                      padding: const EdgeInsets.only(left: 14.5, right: 14.5),
                      child: GestureDetector(
                        onTap: () {
                          log.debug('Tap ball');
                          getMagic();
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset('assets/images/Ball.png'),
                            Image.asset(
                              'assets/images/Vector.png',
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
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Image.asset(
                      'assets/images/Ellipse.png',
                      // color: color,
                    ),
                  ],
                ),
              ),
              const DesktopBottomTextWidget()
            ],
          ),
        ),
      ),
    );
  }
}
