import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/scholarship_model.dart';
import '../../repository/scholarship_repository.dart';
import '../../utils/general_utils.dart';
import '../base_view_model.dart';

class ScholarshipViewModel extends BaseViewModel {
  final ScholarshipRepository repository;
  ScholarshipViewModel({required this.repository});
  List<ScholarshipModel> listScholarship = [];

  List<ScholarshipModel> get scholarshipModel => listScholarship;
  @override
  void onInitView(BuildContext context) {
    getScholarship().then((_) {
      updateUI();
    });
    super.onInitView(context);
  }

  void shouldOnRefreshHandler() {
    getScholarship();
  }

  Future getScholarship() async {
    listScholarship = await repository.getScholarship();
  }

  Future<void> getSearch(String value) async {
    try {
      listScholarship = await repository.getScholarship();
      listScholarship =
          listScholarship.where((element) => element.email!.contains(value.toLowerCase())).toList();
      updateUI();
    } catch (e) {
      Utils.showToast(message: e.toString());
    }
  }

  Future<void> getCombinedSearch(String classValue, String rankValue) async {
    try {
      listScholarship = await repository.getScholarship();
      listScholarship = listScholarship
          .where((element) => element.classRoom!.contains(classValue.trim()))
          .toList();
      listScholarship =
          listScholarship.where((element) => element.rank!.contains(rankValue.trim())).toList();

      updateUI();
    } catch (e) {
      Utils.showToast(message: e.toString());
    }
  }

  Future<void> getSearchClass(String classValue) async {
    try {
      listScholarship = await repository.getScholarship();
      listScholarship = listScholarship
          .where((element) => element.classRoom!.contains(classValue.trim()))
          .toList();
      updateUI();
    } catch (e) {
      Utils.showToast(message: e.toString());
    }
  }

  Future<void> getSearchRank(String rankValue) async {
    try {
      listScholarship = await repository.getScholarship();

      listScholarship =
          listScholarship.where((element) => element.rank!.contains(rankValue.trim())).toList();

      updateUI();
    } catch (e) {
      Utils.showToast(message: e.toString());
    }
  }

  Future<void> deleteDocument(String documentId) async {
    try {
      final documentRef = FirebaseFirestore.instance.collection("scholarships").doc(documentId);
      await documentRef.delete();
      listScholarship = await repository.getScholarship();
      updateUI();
      print('Document deleted successfully');
    } catch (e) {
      print('Error deleting document: $e');
    }
  }
}
