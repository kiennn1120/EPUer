import 'package:flutter/material.dart';
import '../../view/widgets/status_avatar.dart';
import '../../view/widgets/ui_text.dart';

import '../../res/style/app_colors.dart';
import '../../utils/dimens/dimens_manager.dart';

class UiItemChat extends StatelessWidget {
  const UiItemChat({
    Key? key,
    required this.activeAvatar,
    required this.textName,
    required this.fontWeightName,
    required this.textChat,
    required this.fontWeightChat,
    required this.timeChat,
    required this.colorTextChat,
    required this.onTap,
    required this.avatar,
    required this.isMe,
  }) : super(key: key);

  final bool activeAvatar;
  final String textName;
  final String avatar;
  final FontWeight fontWeightName;
  final String textChat;
  final Color colorTextChat;
  final FontWeight fontWeightChat;
  final String timeChat;
  final VoidCallback onTap;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        width: DimensManager.dimens.setWidth(390),
        height: DimensManager.dimens.setHeight(76),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 3,
              child: StatusAvatar(
                sizeMax: true,
                activeStatus: activeAvatar,
              ),
            ),
            Expanded(
              flex: 9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  UIText(
                    textName,
                    style: TextStyle(
                      fontSize: DimensManager.dimens.setSp(16),
                      color: AppColors.headerTextColor,
                      fontWeight: fontWeightName,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 230,
                        child: UIText(
                          isMe ? 'Bạn:$textChat' : textChat,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: DimensManager.dimens.setSp(14),
                            color: colorTextChat,
                            fontWeight: fontWeightChat,
                          ),
                        ),
                      ),
                      UIText(
                        timeChat,
                        style: TextStyle(
                          fontSize: DimensManager.dimens.setSp(14),
                          color: colorTextChat,
                          fontWeight: fontWeightChat,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
