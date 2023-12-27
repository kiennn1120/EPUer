import 'package:flutter/material.dart';
import '../../res/constant/app_fonts.dart';

import '../../res/style/app_colors.dart';

class UITextStyles {
  UITextStyles._();
  static const TextStyle title = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.title,
      fontFamily: AppFonts.nunito);
  static const TextStyle hint =
      TextStyle(fontSize: 13, color: AppColors.border, fontFamily: AppFonts.nunito);
  static const TextStyle textBlack =
      TextStyle(fontSize: 13, color: AppColors.black, fontFamily: AppFonts.nunito);
  static const TextStyle textWhite =
      TextStyle(fontSize: 13, color: AppColors.white, fontFamily: AppFonts.nunito);
  static const TextStyle textBlue =
      TextStyle(fontSize: 13, color: AppColors.blue, fontFamily: AppFonts.nunito);
}
