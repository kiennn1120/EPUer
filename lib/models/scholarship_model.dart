import 'package:cloud_firestore/cloud_firestore.dart';

class ScholarshipModel {
  final String documentId;
  final String? name;
  final String? email;
  final String? classRoom;
  final String? rank;
  final String? bonus;

  ScholarshipModel(
      {required this.documentId, this.classRoom, this.rank, this.bonus, this.name, this.email});

  factory ScholarshipModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ScholarshipModel(
      documentId: snapshot.id, // Gán Document ID
      name: data?['name'] ?? '',
      classRoom: data?['classRoom'] ?? '',
      rank: data?['rank'] ?? '',
      email: data?['email'] ?? '',
      bonus: data?['bonus'] ?? '',
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      if (documentId != null) "Document ID": documentId,
      if (name != null) "name": name,
      if (classRoom != null) "email": classRoom,
      if (rank != null) "role": rank,
      if (email != null) "email": email,
      if (bonus != null) "major": bonus,
    };
  }
}
