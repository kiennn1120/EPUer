import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/open_training_point_model.dart';
import '../../models/training_point_model.dart';
import '../../models/user_model.dart';

class TrainingPointRepository {
  Future<TrainingPointModel?> getTrainingPoint(String email, String semester) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final QuerySnapshot<Map<String, dynamic>> querySnapshot = await db
        .collection('trainingPoints')
        .where('email', isEqualTo: email)
        .where('semester', isEqualTo: semester)
        .get();

    final List<DocumentSnapshot<Map<String, dynamic>>> documents = querySnapshot.docs;
    if (documents.isNotEmpty) {
      final DocumentSnapshot<Map<String, dynamic>> document = documents.first;
      final TrainingPointModel trainingPoint = TrainingPointModel.fromFirestore(document, null);
      return trainingPoint;
    } else {
      print('No training point');
      return null;
    }
  }

  Future<List<TrainingPointModel>> getTrainingPointAll(String email) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await db.collection('trainingPoints').where('email', isEqualTo: email).get();

    final List<DocumentSnapshot<Map<String, dynamic>>> documents = querySnapshot.docs;

    List<TrainingPointModel> array1 = [];
    List<TrainingPointModel> array2 = [];
    List<TrainingPointModel> array3 = [];
    List<TrainingPointModel> array4 = [];

    for (var document in documents) {
      final TrainingPointModel trainingPoint = TrainingPointModel.fromFirestore(document, null);
      final semester = int.parse(trainingPoint.semester!);

      if (semester == 222 || semester == 122) {
        array1.add(trainingPoint);
      } else if (semester == 221 || semester == 121) {
        array2.add(trainingPoint);
      } else if (semester == 220 || semester == 120) {
        array3.add(trainingPoint);
      } else if (semester == 119 || semester == 219) {
        array4.add(trainingPoint);
      }
    }
    array1.sort((a, b) => a.semester!.compareTo(b.semester!));
    array2.sort((a, b) => a.semester!.compareTo(b.semester!));
    array3.sort((a, b) => a.semester!.compareTo(b.semester!));
    array4.sort((a, b) => a.semester!.compareTo(b.semester!));
    array1 = array1.reversed.toList();
    array2 = array2.reversed.toList();
    array3 = array3.reversed.toList();
    array4 = array4.reversed.toList();
    List<TrainingPointModel> trainingPoints = [...array1, ...array2, ...array3, ...array4];

    return trainingPoints;
  }

  Future<OpenTrainingPointModel?> getOpenTrainingPoint() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await db.collection('openTrainingPoints').get();

    final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents = querySnapshot.docs;
    if (documents.isNotEmpty) {
      final QueryDocumentSnapshot<Map<String, dynamic>> document = documents.first;
      final OpenTrainingPointModel openTrainingPointModel =
          OpenTrainingPointModel.fromFirestore(document, null);
      return openTrainingPointModel;
    } else {
      print('No open training point');
      return null;
    }
  }

  Future<UsersModel?> getUser(String email) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await db.collection('users').where('email', isEqualTo: email).get();
    final List<DocumentSnapshot<Map<String, dynamic>>> documents = querySnapshot.docs;
    if (documents.isNotEmpty) {
      final UsersModel user = UsersModel.fromFirestore(documents.first, null);
      return user;
    } else {
      print('No user found with email: $email');
      return null;
    }
  }

  Future<List<TrainingPointModel>> getListTrainingPoints() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await db.collection('trainingPoints').where('semester', isEqualTo: "222").get();

    final List<DocumentSnapshot<Map<String, dynamic>>> documents = querySnapshot.docs;
    final List<TrainingPointModel> trainingPoints = [];

    for (var document in documents) {
      final TrainingPointModel trainingPoint = TrainingPointModel.fromFirestore(document, null);
      trainingPoints.add(trainingPoint);
    }

    if (trainingPoints.isNotEmpty) {
      return trainingPoints;
    } else {
      print('No training points');
      return [];
    }
  }
}

Future<List<TrainingPointModel>> searchTrainingPointByName(String name) async {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await db.collection('trainingPoints').where('name', isEqualTo: name).get();

  final List<DocumentSnapshot<Map<String, dynamic>>> documents = querySnapshot.docs;
  final List<TrainingPointModel> trainingPoints = [];

  for (var document in documents) {
    final TrainingPointModel trainingPoint = TrainingPointModel.fromFirestore(document, null);
    trainingPoints.add(trainingPoint);
  }

  if (trainingPoints.isNotEmpty) {
    return trainingPoints;
  } else {
    print('No training points found with name: $name');
    return [];
  }
}
