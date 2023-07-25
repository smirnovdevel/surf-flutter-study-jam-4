import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:surf_practice_magic_ball/common/app_color.dart';
import 'package:surf_practice_magic_ball/presentation/provider/magic_state_provider.dart';
import 'package:surf_practice_magic_ball/utils/core/delayed.dart';

import '../../../utils/core/logging.dart';
import '../../provider/magic_manager.dart';
import '../../provider/magic_notifer_provider.dart';
import '../../widgets/desktop/desktop_bottom_text_widget.dart';

final Logging log = Logging('DesktopBallScreen');
late Color color;

class DesktopBallScreen extends ConsumerWidget {
  const DesktopBallScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log.debug('Screen');
    final height = MediaQuery.of(context).size.height;
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
                        const SizedBox(
                          height: 20,
                        ),
                        AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastOutSlowIn,
                          padding:
                              const EdgeInsets.only(left: 14.5, right: 14.5),
                          child: GestureDetector(
                            onTap: () {
                              log.debug('Tap ball');
                              ref.watch(magicManagerProvider).getMagic();
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/Ball.png',
                                  height: height - 500,
                                  fit: BoxFit.cover,
                                ),
                                Image.asset(
                                  'assets/images/Vector.png',
                                  height: height - 500,
                                  fit: BoxFit.cover,
                                  color: color,
                                ),
                                Text(
                                  message ?? '',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontFamily: 'Gill Sans',
                                    color: Colors.white,
                                    fontSize: 36.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Image.asset(
                          'assets/images/Ellipse.png', height: height - 900,
                          fit: BoxFit.cover,
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
        ],
      ),
    );
  }
}
