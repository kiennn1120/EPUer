import 'package:flutter/material.dart';
import '../../res/style/app_colors.dart';
import '../../utils/dimens/dimens_manager.dart';
import '../../view/widgets/ui_text.dart';

class UIOutlineButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry padding;
  final String title;
  final TextStyle? titleStyle;
  final Color? backgroundColor;
  final Widget? icon;
  final bool isEnabled;

  const UIOutlineButton({
    Key? key,
    this.onPressed,
    required this.title,
    this.padding = EdgeInsets.zero,
    this.titleStyle,
    this.backgroundColor,
    this.icon,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: OutlinedButton(
        onPressed: isEnabled == true ? onPressed : null,
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor != null
              ? backgroundColor!.withOpacity(isEnabled == true ? 1 : 0.5)
              : Colors.white,
          minimumSize: Size(double.infinity, DimensManager.dimens.setHeight(48)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DimensManager.dimens.setRadius(20)),
          ),
          side: BorderSide(color: AppColors.primaryColor.withOpacity(isEnabled == true ? 1 : 0.5)),
        ),
        child: FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon ?? const SizedBox.shrink(),
              if (icon != null)
                SizedBox(
                  width: DimensManager.dimens.setWidth(10),
                ),
              UIText(
                title,
                style: TextStyle(
                        color: backgroundColor != null ? Colors.white : AppColors.primaryColor,
                        fontSize: DimensManager.dimens.setSp(16),
                        fontWeight: FontWeight.w600)
                    .merge(titleStyle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
