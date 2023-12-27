import 'package:flutter/material.dart' hide Notification;

import '../../../models/notification_model.dart';
import '../../../res/constant/app_assets.dart';
import '../../../res/style/app_colors.dart';
import '../../../utils/dimens/dimens_manager.dart';
import '../../../view/widgets/ui_text.dart';

const kThumbnailSize = 56.0;

class NotificationItemWidget extends StatelessWidget {
  NotificationItemWidget({required this.notification, super.key});
  NotificationModel notification;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: Container(
        padding: EdgeInsets.all(DimensManager.dimens.setWidth(16)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: _buildThumbnail(),
            ),
            SizedBox(
              width: DimensManager.dimens.setWidth(16),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UIText(notification.title ?? "",
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: AppColors.primaryColor)),
                  UIText(
                    notification.describe ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.gray),
                  ),
                  SizedBox(
                    height: DimensManager.dimens.setHeight(8),
                  ),
                  Text(
                    calculateTimeAgo(notification.createAt),
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 12, color: AppColors.blue),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String calculateTimeAgo(DateTime? time) {
    if (time == null) {
      return '';
    }

    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} giây trước';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} phút trước';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} giờ trước';
    } else {
      return '${difference.inDays} ngày trước';
    }
  }

  Widget _buildThumbnail() {
    return Image.asset(
      AppAssets.icNotificationMini,
      width: DimensManager.dimens.setWidth(kThumbnailSize),
      height: DimensManager.dimens.setWidth(kThumbnailSize),
      fit: BoxFit.cover,
    );
  }
}
