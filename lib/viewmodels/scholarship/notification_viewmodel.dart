import '../../models/notification_model.dart';
import '../../models/user_model.dart';
import '../../repository/notification_repository.dart';
import '../base_view_model.dart';

class NotificationViewModel extends BaseViewModel {
  final NotificationRepository repository;
  NotificationViewModel({required this.repository});
  List<NotificationModel> listNotification = [];
  UsersModel? usersModel;
  List<NotificationModel> get notificationModel => listNotification;
  Future<void> getNotification(String email) async {
    listNotification = await repository.getNotification(email);
    updateUI();
  }
}
