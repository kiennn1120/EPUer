import 'package:flutter/material.dart';

import '../../../res/style/app_colors.dart';
import '../../../utils/dimens/dimens_manager.dart';
import '../../../view/widgets/ui_text.dart';

class InforRowWidget extends StatelessWidget {
  const InforRowWidget({required this.title, required this.value, super.key});
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        UIText(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: AppColors.gray),
        ),
        SizedBox(
          width: DimensManager.dimens.setWidth(8),
        ),
        Expanded(
          child: UIText(
            value,
            textAlign: TextAlign.right,
            style:
                const TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: AppColors.gray),
          ),
        )
      ],
    );
  }
}
