import 'package:flutter/material.dart';

import '../../res/style/app_colors.dart';
import '../../utils/dimens/dimens_manager.dart';

class UiInputChat extends StatelessWidget {
  UiInputChat({
    required this.onChanged,
    required this.controller,
    super.key,
  });
  void Function(String)? onChanged;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        width: DimensManager.dimens.setWidth(322),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.0),
          color: Colors.black.withOpacity(0.05),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: TextField(
            onChanged: onChanged,
            controller: controller,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(
                  fontSize: DimensManager.dimens.setSp(16),
                  color: AppColors.hintSendChat,
                  fontWeight: FontWeight.w400),
              hintText: "Nhập tin nhắn...",
            ),
          ),
        ));
  }
}
