import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String? name;
  final String? email;
  final String? title;
  final String? describe;
  final String? type;
  final DateTime? createAt;

  NotificationModel({
    this.title,
    this.describe,
    this.name,
    this.email,
    this.type,
    this.createAt,
  });

  factory NotificationModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return NotificationModel(
      name: data?['name'],
      email: data?['email'],
      title: data?['title'],
      describe: data?['describe'],
      type: data?['type'],
      createAt: (data?['createAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (email != null) "email": email,
      if (title != null) "title": title,
      if (describe != null) "describe": describe,
      if (type != null) "type": type,
      if (createAt != null) "time": Timestamp.fromDate(createAt!),
    };
  }
}
