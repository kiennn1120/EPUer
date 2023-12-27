import 'package:cloud_firestore/cloud_firestore.dart';

class OpenTrainingPointModel {
  final bool? open;
  final String? semester;
  final DateTime? createAt;

  OpenTrainingPointModel({
    this.semester,
    this.open,
    this.createAt,
  });

  factory OpenTrainingPointModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return OpenTrainingPointModel(
      open: data?['open'] as bool?,
      semester: data?['semester'] as String?,
      createAt: (data?['createAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (open != null) "open": open,
      if (semester != null) "semester": semester,
      if (createAt != null) "dateTime": Timestamp.fromDate(createAt!),
    };
  }
}
