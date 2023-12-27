import 'package:flutter/material.dart';
import '../../view/constant/ui_button_styles.dart';
import '../../view/constant/ui_text_styles.dart';

class BasicButton extends StatelessWidget {
  const BasicButton({required this.text, required this.onPressed, super.key});
  final String? text;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: UIButtonStyles.buttonStyle,
      child: Text(
        text ?? "",
        style: UITextStyles.textWhite,
      ),
    );
  }
}

class BackTextButton extends StatelessWidget {
  const BackTextButton({required this.text, required this.onPressed, super.key});
  final String? text;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text ?? '',
        style: UITextStyles.textBlue,
      ),
    );
  }
}
