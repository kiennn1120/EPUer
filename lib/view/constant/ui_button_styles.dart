import 'package:flutter/material.dart';
import '../../res/style/app_colors.dart';

class UIButtonStyles {
  UIButtonStyles._();
  static final ButtonStyle buttonStyle = ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(vertical: 16)),
    backgroundColor: MaterialStateProperty.all(AppColors.button),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(50), side: BorderSide.none)),
  );
  // static final ButtonStyle greenBorderButtonStyle = ButtonStyle(
  //   padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(vertical: 16)),
  //   backgroundColor: MaterialStateProperty.all(primaryColor),
  //   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(50), side: BorderSide.none)),
  // );
  // static final ButtonStyle disableButtonStyle = ButtonStyle(
  //   padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(vertical: 16)),
  //   backgroundColor: MaterialStateProperty.all(UIColors.border),
  //   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  //     RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(50),
  //       side: BorderSide.none,
  //     ),
  //   ),
  // );

  // static final ButtonStyle redButtonStyle = ButtonStyle(
  //   padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(vertical: 15)),
  //   backgroundColor: MaterialStateProperty.all(redColor),
  //   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(50), side: BorderSide.none)),
  // );
}
