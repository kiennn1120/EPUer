import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../res/constant/app_assets.dart';
import '../../res/style/app_colors.dart';

class UISearchInput extends StatelessWidget {
  const UISearchInput({this.onChangeValue, super.key});
  final void Function(String)? onChangeValue;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChangeValue,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 16, bottom: 12),
          border: InputBorder.none,
          fillColor: AppColors.gray,
          focusColor: AppColors.gray,
          hoverColor: AppColors.gray,
          hintText: 'Tìm kiếm....',
          hintStyle: const TextStyle(fontSize: 15, color: AppColors.hintTextColor),
          prefixIcon: Container(
            padding: const EdgeInsets.only(top: 16, bottom: 12, left: 24, right: 12),
            child: SvgPicture.asset(
              AppAssets.icSearchsGrey,
              fit: BoxFit.cover,
              width: 20,
              height: 20,
            ),
          )),
    );
  }
}
