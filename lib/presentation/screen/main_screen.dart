import 'package:flutter/material.dart';

import '../../../utils/core/logging.dart';
import '../common_widgets/responsive_widget.dart';
import 'desktop/desktop_ball_screen.dart';
import 'mobile/mobile_ball_screen.dart';
import 'tablet/tablet_ball_screen.dart';

final Logging log = Logging('MainScreen');

class MainBallScreen extends StatelessWidget {
  const MainBallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    // log.debug('Screen resolution height: ${size.height} width: ${size.width}');
    return const ResponsiveWidget(
      mobileWidget: MobileBallScreen(),
      tabletWidget: TabletBallScreen(),
      desktopWidget: DesktopBallScreen(),
    );
  }
}
