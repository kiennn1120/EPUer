import 'package:flutter/material.dart';
import '../../res/style/app_colors.dart';
import '../../utils/dimens/dimens_manager.dart';
import '../../view/widgets/ui_icon_button.dart';
import '../../view/widgets/ui_radio_button.dart';
import '../../view/widgets/ui_text.dart';

typedef OnRadioChanged = Function(dynamic);

class UIRadioTitle extends StatelessWidget {
  final String title;
  final dynamic value;
  final dynamic groupValue;
  final OnRadioChanged? onChanged;
  final bool? isSelected;
  const UIRadioTitle(
      {Key? key,
      required this.title,
      required this.value,
      required this.groupValue,
      this.onChanged,
      this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        UIIconButton(
          child: UIRadioButton(
            size: DimensManager.dimens.setRadius(24),
            selected: (value == groupValue),
          ),
          onPressed: () {
            onChanged?.call(value);
          },
        ),
        if (title.isNotEmpty) ...[
          SizedBox(width: DimensManager.dimens.setRadius(12)),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: FittedBox(
                child: UIText(
                  title,
                  style: TextStyle(
                    fontSize: DimensManager.dimens.setSp(14),
                    fontWeight: FontWeight.w500,
                    color: AppColors.inFieldTextColor,
                  ),
                ),
              ),
            ),
          ),
        ]
      ],
    );
  }
}
