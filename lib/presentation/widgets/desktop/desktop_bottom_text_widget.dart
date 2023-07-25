import 'package:flutter/material.dart';

import '../../../utils/core/scale_size.dart';

class DesktopBottomTextWidget extends StatelessWidget {
  const DesktopBottomTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 56.0),
      child: Column(
        children: [
          Text(
            'Нажмите на шар',
            style: const TextStyle(
              fontFamily: 'Gill Sans',
              color: Color(0xFF727272),
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
            ),
            textScaleFactor: ScaleSize.textScaleFactor(context),
          ),
          Text(
            'или потрясите телефон',
            style: const TextStyle(
              fontFamily: 'Gill Sans',
              color: Color(0xFF727272),
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
            ),
            textScaleFactor: ScaleSize.textScaleFactor(context),
          ),
        ],
      ),
    );
  }
}
