import 'package:flutter/material.dart';
import '../../res/style/app_colors.dart';
import '../../utils/dimens/dimens_manager.dart';

class UIButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool enabled;

  const UIButton({super.key, required this.child, this.onPressed, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      color: enabled == true ? AppColors.primaryColor : AppColors.primaryColor.withOpacity(0.25),
      child: InkWell(
        onTap: enabled == true ? onPressed : null,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: DimensManager.dimens.setWidth(342),
          height: DimensManager.dimens.setHeight(48),
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }
}
