import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/notification_model.dart';

class NotificationRepository {
  Future<List<NotificationModel>> getNotification(String email) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await db.collection('notifications').where('email', isEqualTo: email).get();
    final List<DocumentSnapshot<Map<String, dynamic>>> documents = querySnapshot.docs;
    if (documents.isNotEmpty) {
      final List<NotificationModel> notification = documents.map((doc) {
        return NotificationModel.fromFirestore(doc, null);
      }).toList();
      return notification;
    } else {
      print('No notification');
      return [];
    }
  }
}
