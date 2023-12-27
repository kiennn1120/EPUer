import 'package:cloud_firestore/cloud_firestore.dart';

class TrainingPointModel {
  final String documentId;
  final int? activate1;
  final int? activate2;
  final int? activate3;
  final int? activate4;
  final int? monitor1;
  final int? monitor2;
  final int? monitor3;
  final int? monitor4;
  final String? msv;
  final int? relation1;
  final int? relation2;
  final int? relation3;
  final int? relation4;
  final int? relation5;
  final int? rules1;
  final int? rules2;
  final int? rules3;
  final int? rules4;
  final int? study1;
  final int? study2;
  final int? study3;
  final int? study4;
  final int? study5;
  final int? study6;
  final int? trainingPoint;
  final int? trainingPoint1;
  final int? trainingPoint2;
  final int? trainingPoint3;
  final int? trainingPoint4;
  final int? trainingPoint5;
  final String? gvcn;
  final bool? history;
  final String? rank;
  final String? email;
  final bool? status;
  final int? teacherActivate1;
  final int? teacherActivate2;
  final int? teacherActivate3;
  final int? teacherActivate4;
  final int? teacherMonitor1;
  final int? teacherMonitor2;
  final int? teacherMonitor3;
  final int? teacherMonitor4;
  final int? teacherRelation1;
  final int? teacherRelation2;
  final int? teacherRelation3;
  final int? teacherRelation4;
  final int? teacherRelation5;
  final int? teacherRules1;
  final int? teacherRules2;
  final int? teacherRules3;
  final int? teacherRules4;
  final int? teacherStudy1;
  final int? teacherStudy2;
  final int? teacherStudy3;
  final int? teacherStudy4;
  final int? teacherStudy5;
  final int? teacherStudy6;
  final int? teacherTrainingPoint;
  final int? teacherTrainingPoint1;
  final int? teacherTrainingPoint2;
  final int? teacherTrainingPoint3;
  final int? teacherTrainingPoint4;
  final int? teacherTrainingPoint5;
  final String? teacherRank;
  final String? semester;
  TrainingPointModel({
    required this.documentId,
    this.activate1,
    this.activate2,
    this.activate3,
    this.activate4,
    this.monitor1,
    this.monitor2,
    this.monitor3,
    this.monitor4,
    this.msv,
    this.relation1,
    this.relation2,
    this.relation3,
    this.relation4,
    this.relation5,
    this.rules1,
    this.rules2,
    this.rules3,
    this.rules4,
    this.study1,
    this.study2,
    this.study3,
    this.study4,
    this.study5,
    this.study6,
    this.trainingPoint,
    this.trainingPoint1,
    this.trainingPoint2,
    this.trainingPoint3,
    this.trainingPoint4,
    this.trainingPoint5,
    this.gvcn,
    this.rank,
    this.teacherRank,
    this.email,
    this.status,
    this.history,
    this.teacherActivate1,
    this.teacherActivate2,
    this.teacherActivate3,
    this.teacherActivate4,
    this.teacherMonitor1,
    this.teacherMonitor2,
    this.teacherMonitor3,
    this.teacherMonitor4,
    this.teacherRelation1,
    this.teacherRelation2,
    this.teacherRelation3,
    this.teacherRelation4,
    this.teacherRelation5,
    this.teacherRules1,
    this.teacherRules2,
    this.teacherRules3,
    this.teacherRules4,
    this.teacherStudy1,
    this.teacherStudy2,
    this.teacherStudy3,
    this.teacherStudy4,
    this.teacherStudy5,
    this.teacherStudy6,
    this.teacherTrainingPoint,
    this.teacherTrainingPoint1,
    this.teacherTrainingPoint2,
    this.teacherTrainingPoint3,
    this.teacherTrainingPoint4,
    this.teacherTrainingPoint5,
    this.semester,
  });

  factory TrainingPointModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return TrainingPointModel(
      documentId: snapshot.id,
      activate1: data?["activate1"],
      activate2: data?["activate2"],
      activate3: data?["activate3"],
      activate4: data?["activate4"],
      monitor1: data?["monitor1"],
      monitor2: data?["monitor2"],
      monitor3: data?["monitor3"],
      monitor4: data?["monitor4"],
      msv: data?["msv"],
      relation1: data?["relation1"],
      relation2: data?["relation2"],
      relation3: data?["relation3"],
      relation4: data?["relation4"],
      relation5: data?["relation5"],
      rules1: data?["rules1"],
      rules2: data?["rules2"],
      rules3: data?["rules3"],
      rules4: data?["rules4"],
      study1: data?["study1"],
      study2: data?["study2"],
      study3: data?["study3"],
      study4: data?["study4"],
      study5: data?["study5"],
      study6: data?["study6"],
      trainingPoint: data?["trainingPoint"],
      trainingPoint1: data?["trainingPoint1"],
      trainingPoint2: data?["trainingPoint2"],
      trainingPoint3: data?["trainingPoint3"],
      trainingPoint4: data?["trainingPoint4"],
      trainingPoint5: data?["trainingPoint5"],
      gvcn: data?["gvcn"],
      history: data?["history"],
      rank: data?["rank"],
      teacherRank: data?["teacherRank"],
      email: data?["email"],
      status: data?["status"],
      teacherActivate1: data?["teacherActivate1"],
      teacherActivate2: data?["teacherActivate2"],
      teacherActivate3: data?["teacherActivate3"],
      teacherActivate4: data?["teacherActivate4"],
      teacherMonitor1: data?["teacherMonitor1"],
      teacherMonitor2: data?["teacherMonitor2"],
      teacherMonitor3: data?["teacherMonitor3"],
      teacherMonitor4: data?["teacherMonitor4"],
      teacherRelation1: data?["teacherRelation1"],
      teacherRelation2: data?["teacherRelation2"],
      teacherRelation3: data?["teacherRelation3"],
      teacherRelation4: data?["teacherRelation4"],
      teacherRelation5: data?["teacherRelation5"],
      teacherRules1: data?["teacherRules1"],
      teacherRules2: data?["teacherRules2"],
      teacherRules3: data?["teacherRules3"],
      teacherRules4: data?["teacherRules4"],
      teacherStudy1: data?["teacherStudy1"],
      teacherStudy2: data?["teacherStudy2"],
      teacherStudy3: data?["teacherStudy3"],
      teacherStudy4: data?["teacherStudy4"],
      teacherStudy5: data?["teacherStudy5"],
      teacherStudy6: data?["teacherStudy6"],
      teacherTrainingPoint: data?["teacherTrainingPoint"],
      teacherTrainingPoint1: data?["teacherTrainingPoint1"],
      teacherTrainingPoint2: data?["teacherTrainingPoint2"],
      teacherTrainingPoint3: data?["teacherTrainingPoint3"],
      teacherTrainingPoint4: data?["teacherTrainingPoint4"],
      teacherTrainingPoint5: data?["teacherTrainingPoint5"],
      semester: data?["semester"],
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      if (documentId != null) "Document ID": documentId,
      if (activate1 != null) 'activate1': activate1,
      if (activate2 != null) 'activate2': activate2,
      if (activate3 != null) 'activate3': activate3,
      if (activate4 != null) 'activate4': activate4,
      if (monitor1 != null) 'monitor1': monitor1,
      if (monitor2 != null) 'monitor2': monitor2,
      if (monitor3 != null) 'monitor3': monitor3,
      if (monitor4 != null) 'monitor4': monitor4,
      if (msv != null) 'msv': msv,
      if (relation1 != null) 'relation1': relation1,
      if (relation2 != null) 'relation2': relation2,
      if (relation3 != null) 'relation3': relation3,
      if (relation4 != null) 'relation4': relation4,
      if (relation5 != null) 'relation5': relation5,
      if (rules1 != null) 'rules1': rules1,
      if (rules2 != null) 'rules2': rules2,
      if (rules3 != null) 'rules3': rules3,
      if (rules4 != null) 'rules4': rules4,
      if (study1 != null) 'study1': study1,
      if (study2 != null) 'study2': study2,
      if (study3 != null) 'study3': study3,
      if (study4 != null) 'study4': study4,
      if (study5 != null) 'study5': study5,
      if (study6 != null) 'study6': study6,
      if (trainingPoint != null) 'trainingPoint': trainingPoint,
      if (trainingPoint1 != null) 'trainingPoint1': trainingPoint1,
      if (trainingPoint2 != null) 'trainingPoint2': trainingPoint2,
      if (trainingPoint3 != null) 'trainingPoint3': trainingPoint3,
      if (trainingPoint4 != null) 'trainingPoint4': trainingPoint4,
      if (trainingPoint5 != null) 'trainingPoint5': trainingPoint5,
      if (gvcn != null) 'gvcn': gvcn,
      if (history != null) 'history': history,
      if (rank != null) 'rank': rank,
      if (email != null) 'email': email,
      if (status != null) 'status': status,
    };
  }
}
