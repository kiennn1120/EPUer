import 'package:flutter/material.dart';
import '../../view/widgets/ui_text.dart';

import '../../utils/dimens/dimens_manager.dart';

class UiChatSwitchButton extends StatelessWidget {
  UiChatSwitchButton(
      {super.key,
      required this.onTap,
      required this.colorBG,
      required this.colorText,
      required this.text});
  final void Function()? onTap;
  final Color colorBG;
  final Color colorText;
  final String text;

  bool activeButton = true;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: DimensManager.dimens.setWidth(170),
        height: DimensManager.dimens.setHeight(28),
        decoration: BoxDecoration(
            color: colorBG,
            borderRadius: BorderRadius.all(Radius.circular(DimensManager.dimens.setSp(14)))),
        child: Center(
          child: UIText(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: DimensManager.dimens.setSp(13),
                color: colorText,
                fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }
}
