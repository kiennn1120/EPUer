import 'package:flutter/material.dart' hide Notification;
import 'package:provider/provider.dart';

import '../../models/notification_model.dart';
import '../../repository/notification_repository.dart';
import '../../res/constant/app_assets.dart';
import '../../res/style/app_colors.dart';
import '../../utils/dimens/dimens_manager.dart';
import '../../utils/routes/routes_name.dart';
import '../../view/notification/widget/notification_item_widget.dart';
import '../../view/widgets/appbar.dart';
import '../../view/widgets/ui_empty_screen.dart';
import '../../view/widgets/ui_search_input.dart';
import '../../viewmodels/scholarship/notification_viewmodel.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({required this.email, Key? key}) : super(key: key);
  String email;

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late NotificationViewModel viewModel;

  @override
  void initState() {
    viewModel = NotificationViewModel(repository: NotificationRepository())..onInitView(context);
    viewModel.getNotification(widget.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appBar(context, 'Thông báo', leading: false),
        body: Column(
          children: [
            const UISearchInput(),
            Container(
              color: AppColors.white,
              padding: EdgeInsets.only(
                left: DimensManager.dimens.setWidth(16),
                right: DimensManager.dimens.setWidth(16),
                top: DimensManager.dimens.setHeight(20),
                bottom: DimensManager.dimens.setWidth(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Selector<NotificationViewModel, List<NotificationModel>>(
                    selector: (_, viewModel) => viewModel.listNotification,
                    builder: (context, value, child) => Text(
                      '${viewModel.listNotification.length} thông báo mới',
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                  ),
                  const Text(
                    'Đánh dấu đã đọc',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Selector<NotificationViewModel, List<NotificationModel>>(
                selector: (_, viewModel) => viewModel.listNotification,
                builder: (context, value, child) {
                  if (viewModel.listNotification.isNotEmpty) {
                    return Container(
                      color: AppColors.white,
                      child: ListView.builder(
                        itemCount: viewModel.listNotification.length,
                        itemBuilder: (context, index) {
                          final notification = viewModel.listNotification[index];
                          if (notification.type == "scholarship") {
                            return GestureDetector(
                              onTap: () => Navigator.pushNamed(context, RoutesName.encouragingStudy,
                                  arguments: "student"),
                              child: NotificationItemWidget(notification: notification),
                            );
                          } else if (notification.type == "trainingPoint") {
                            return GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                  context, RoutesName.trainingPointHistory,
                                  arguments: widget.email),
                              child: NotificationItemWidget(notification: notification),
                            );
                          }
                          // Thêm xử lý cho các trường hợp khác nếu cần thiết

                          return Container(); // Trả về widget mặc định nếu không có trường hợp nào phù hợp
                        },
                      ),
                    );
                  } else {
                    return const UIEmptyScreen(
                      iconAsset: AppAssets.icNoHistory,
                      title: 'Không có thông báo nào!',
                      message: 'Không có thông báo nào dành cho bạn.\nVui lòng kiểm tra lại!',
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
