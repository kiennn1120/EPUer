import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../view/widgets/ui_text.dart';

import '../../utils/dimens/dimens_manager.dart';

class UiHomeMainButton extends StatelessWidget {
  const UiHomeMainButton(
      {super.key,
      required this.onTap,
      required this.color,
      required this.icon,
      required this.text,
      required this.width});
  final VoidCallback onTap;
  final Color color;
  final String icon;
  final String text;
  final double width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: DimensManager.dimens.setHeight(135),
        width: DimensManager.dimens.setWidth(170),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(
              top: DimensManager.dimens.setHeight(12), bottom: DimensManager.dimens.setHeight(8)),
          child: Column(children: [
            SvgPicture.asset(icon,
                height: DimensManager.dimens.setHeight(60),
                width: DimensManager.dimens.setWidth(60)),
            SizedBox(height: DimensManager.dimens.setHeight(10)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: UIText(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: DimensManager.dimens.setSp(18),
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
