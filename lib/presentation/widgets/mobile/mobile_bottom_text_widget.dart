import 'package:flutter/material.dart';

class MobileBottomTextWidget extends StatelessWidget {
  const MobileBottomTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 56.0),
      child: Column(
        children: [
          Text(
            'Нажмите на шар',
            style: TextStyle(
              fontFamily: 'Gill Sans',
              color: Color(0xFF727272),
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            'или потрясите телефон',
            style: TextStyle(
              fontFamily: 'Gill Sans',
              color: Color(0xFF727272),
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
