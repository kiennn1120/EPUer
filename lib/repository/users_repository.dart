import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/user_model.dart';

class UsersRepository {
  Future<List<UsersModel>> getUsers() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final QuerySnapshot<Map<String, dynamic>> querySnapshot = await db.collection('users').get();
    final List<DocumentSnapshot<Map<String, dynamic>>> documents = querySnapshot.docs;
    if (documents.isNotEmpty) {
      final List<UsersModel> users = documents.map((doc) {
        return UsersModel.fromFirestore(doc, null);
      }).toList();
      return users;
    } else {
      print('No users');
      return [];
    }
  }
}
