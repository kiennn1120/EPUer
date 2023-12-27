import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../res/style/app_colors.dart';
import '../../utils/dimens/dimens_manager.dart';

class UIEmptyScreen extends StatelessWidget {
  const UIEmptyScreen({required this.iconAsset, required this.title, this.message, super.key});
  final String iconAsset;
  final String title;
  final String? message;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: DimensManager.dimens.setHeight(190),
          ),
          SvgPicture.asset(
            iconAsset,
            width: DimensManager.dimens.setWidth(150),
            height: DimensManager.dimens.setWidth(150),
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
