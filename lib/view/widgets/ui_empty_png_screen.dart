import 'package:flutter/material.dart';
import '../../res/style/app_colors.dart';
import '../../utils/dimens/dimens_manager.dart';

class UIEmptyPngScreen extends StatelessWidget {
  const UIEmptyPngScreen({required this.iconAsset, required this.title, this.message, super.key});
  final String iconAsset;
  final String title;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Opacity(
            opacity: 0.2,
            child: Image.asset(
              iconAsset,
              fit: BoxFit.cover,
              width: DimensManager.dimens.setWidth(150),
              height: DimensManager.dimens.setWidth(150),
            ),
          ),
          SizedBox(
            height: DimensManager.dimens.setHeight(24),
          ),
          Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.w700, fontSize: 20, color: AppColors.headerTextColor),
          ),
          SizedBox(
            height: DimensManager.dimens.setHeight(8),
          ),
          Text(
            message ?? 'Hiện tại chưa có thông báo nào !',
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.hintTextColor),
          )
        ],
      ),
    );
  }
}
