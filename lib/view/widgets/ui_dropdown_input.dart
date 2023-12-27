import 'package:flutter/material.dart';
import '../../res/style/app_colors.dart';
import '../../utils/dimens/dimens_manager.dart';
import '../../view/widgets/ui_text.dart';

typedef OnChanged = Function(String?);

class UIDropdownInput extends StatelessWidget {
  final String title;
  final String? hint;
  final List<String> list;
  final OnChanged? onChanged;
  final bool isRequired;
  final String? initValue;

  const UIDropdownInput(
      {super.key,
      required this.title,
      this.hint,
      required this.list,
      this.onChanged,
      this.isRequired = false,
      this.initValue});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            UIText(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: DimensManager.dimens.setSp(14),
                color: AppColors.contentTextColor,
              ),
            ),
            UIText(
              isRequired ? " *" : "",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: DimensManager.dimens.setSp(14),
                color: AppColors.requiredColor,
              ),
            ),
          ],
        ),
        SizedBox(
          height: DimensManager.dimens.setHeight(5),
        ),
        DropdownButtonFormField(
          menuMaxHeight: DimensManager.dimens.setHeight(300),
          value: initValue,
          isDense: true,
          isExpanded: true,
          itemHeight: 48,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          hint: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              hint!,
              style: TextStyle(
                fontSize: DimensManager.dimens.setSp(14),
                fontWeight: FontWeight.normal,
                color: AppColors.hintTextColor,
                height: 1.25,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: DimensManager.dimens.setWidth(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.inputBorder, width: 1.0),
              borderRadius: BorderRadius.circular(12.0),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.0),
              borderRadius: BorderRadius.circular(12.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.0),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          items: list.map((String val) {
            return DropdownMenuItem(
              value: val,
              child: Text(
                val,
              ),
            );
          }).toList(),
          onChanged: onChanged,
          key: UniqueKey(),
        ),
      ],
    );
  }
}
