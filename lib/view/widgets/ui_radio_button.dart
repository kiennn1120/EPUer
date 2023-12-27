import 'package:flutter/material.dart';
import '../../res/style/app_colors.dart';
import '../../utils/dimens/dimens_manager.dart';

class UIRadioButton extends StatelessWidget {
  final double size;
  final bool selected;
  final bool isSize;
  const UIRadioButton({Key? key, required this.size, this.selected = false, this.isSize = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (selected) {
      return Container(
        height: (isSize == true) ? size + DimensManager.dimens.setRadius(10) : size,
        width: (isSize == true) ? size + DimensManager.dimens.setRadius(10) : size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size),
          color: AppColors.primaryColor,
        ),
        child: Icon(Icons.done_rounded,
            color: Colors.white,
            size: (isSize == true) ? size + DimensManager.dimens.setRadius(10) : 16),
      );
    }

    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFC0C0CE)),
        borderRadius: BorderRadius.circular(size / 2),
      ),
    );
  }
}
