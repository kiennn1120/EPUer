import 'package:cloud_firestore/cloud_firestore.dart';

class UsersModel {
  final String? name;
  final String? email;
  final String? permission;
  final String? msv;
  final String? major;
  final String? department;
  final String? classRoom;
  final String? phone;

  UsersModel(
      {this.classRoom,
      this.phone,
      this.major,
      this.department,
      this.name,
      this.email,
      this.permission,
      this.msv});

  factory UsersModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UsersModel(
      name: data?['name'],
      email: data?['email'],
      permission: data?['permission'],
      msv: data?['msv'],
      major: data?['major'],
      department: data?['department'],
      classRoom: data?['classRoom'],
      phone: data?['phone'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (email != null) "email": email,
      if (permission != null) "permission": permission,
      if (msv != null) "msv": msv,
      if (major != null) "major": major,
      if (department != null) "department": department,
      if (classRoom != null) "classRoom": classRoom,
      if (phone != null) "phone": phone,
    };
  }
}
