import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import '../../repository/users_repository.dart';
import '../../res/constant/app_assets.dart';
import '../../utils/general_utils.dart';
import '../../viewmodels/base_view_model.dart';

CollectionReference scholarship = FirebaseFirestore.instance.collection('scholarships');
CollectionReference notification = FirebaseFirestore.instance.collection('notifications');

class UsersViewModel extends BaseViewModel {
  final UsersRepository repository;
  UsersViewModel({required this.repository});
  List<UsersModel> listemail = [];
  UsersModel? nameOnly;
  List<UsersModel> listUsers = [];
  late UsersModel user;
  List<UsersModel> get usersModel => listUsers;
  @override
  void onInitView(BuildContext context) {
    getUsers().then((_) {
      updateUI();
    });
    super.onInitView(context);
  }

  Future getUsers() async {
    listUsers = await repository.getUsers();
  }

  Future<List<String>> getSearchClass(String classValue) async {
    try {
      listUsers = await repository.getUsers();
      listemail =
          listUsers.where((element) => element.classRoom!.contains(classValue.trim())).toList();
      updateUI();

      List<String> emailList = listemail.map((element) => element.email!).toList();
      List<String> trimmedEmailList =
          emailList.map((email) => email.substring(0, email.indexOf('@'))).toList();

      return trimmedEmailList;
    } catch (e) {
      Utils.showToast(message: e.toString());
      return [];
    }
  }

  Future<String?> getSearchName(String email) async {
    try {
      listUsers = await repository.getUsers();
      List<String> names = listUsers
          .where((element) => element.email!.contains(email.trim()))
          .map((user) => user.name ?? "")
          .toList();
      updateUI();

      return names.isNotEmpty ? names.join(", ") : null;
    } catch (e) {
      Utils.showToast(message: e.toString());
      return null;
    }
  }

  Future<void> addScholarship({
    required String name,
    required String email,
    required String classRoom,
    required String rank,
    required String bonus,
  }) async {
    try {
      final querySnapshot = await scholarship.where('email', isEqualTo: email).get();

      if (querySnapshot.docs.isEmpty) {
        await scholarship.add({
          'name': name,
          'email': email,
          'classRoom': classRoom,
          'rank': rank,
          'bonus': bonus,
        });

        await notification.add({
          'name': name,
          'email': "$email@sv.ute.udn.vn",
          'title': "Thông báo về học bổng",
          'describe': "Chúc mừng bạn đã nhận được học bổng $rank kì vừa rồi",
          'type': "scholarship",
          'createAt': Timestamp.fromDate(DateTime.now()),
        });

        Utils.showPopup(context,
            icon: AppAssets.icCheck,
            title: "Thêm sinh viên thành công",
            message: "Sinh viên đã được thêm vào danh sách học bổng");
      } else {
        Utils.showPopup(context,
            icon: AppAssets.icClose,
            title: "Thêm sinh viên thất bại",
            message: "Sinh viên đã được thêm vào rồi\nThoát ra ngoài nếu muốn xem nhé :3");
      }
    } catch (error) {
      print('Failed to add scholarship: $error');
    }
  }

  Future<void> addNotification({
    required String name,
    required String email,
    required String title,
    required String describe,
    required DateTime createAt,
  }) async {
    try {} catch (e) {}
  }
}
