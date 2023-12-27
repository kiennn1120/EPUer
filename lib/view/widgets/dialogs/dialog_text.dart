import 'package:flutter/material.dart';

import '../../../utils/dimens/dimens_manager.dart';
import '../ui_text.dart';

class TextDialog extends StatelessWidget {
  final String content;

  const TextDialog({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: DimensManager.dimens.setWidth(36),
      ),
      child: UIText(
        content,
        size: DimensManager.dimens.setSp(14),
        fontWeight: FontWeight.w500,
        textAlign: TextAlign.center,
      ),
    );
  }
}
