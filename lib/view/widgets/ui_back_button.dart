import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../res/constant/app_assets.dart';

const kIconSize = 24.0;

class UIBackButton extends StatelessWidget {
  const UIBackButton({this.onPressed, super.key});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: SvgPicture.asset(
        AppAssets.icBack,
        width: kIconSize,
        height: kIconSize,
      ),
      splashRadius: kIconSize,
      iconSize: kIconSize,
      padding: const EdgeInsets.all(0),
    );
  }
}
