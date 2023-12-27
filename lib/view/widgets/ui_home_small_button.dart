import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../view/widgets/ui_text.dart';

import '../../utils/dimens/dimens_manager.dart';

class UiHomeSmallButton extends StatelessWidget {
  const UiHomeSmallButton({
    required this.onTap,
    required this.icon,
    required this.text,
    super.key,
  });
  final VoidCallback onTap;
  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            SvgPicture.asset(icon),
            SizedBox(height: DimensManager.dimens.setHeight(11)),
            UIText(
              text,
              style: TextStyle(
                  fontSize: DimensManager.dimens.setSp(15),
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
