import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/open_training_point_model.dart';
import '../../utils/general_utils.dart';
import '../../utils/routes/routes_name.dart';
import '../res/constant/app_assets.dart';
import '../res/style/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoggedIn = false; // Biến để kiểm tra trạng thái đăng nhập
  OpenTrainingPointModel? openTrainingPointModel;

  @override
  void initState() {
    super.initState();
    getOpenTrainingPoint();

    countDownTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(flex: 1, child: SizedBox()),
          Expanded(
            flex: 3,
            child: Hero(
              tag: 'University',
              child: Image.asset(
                AppAssets.iconUniversity,
                width: 145,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(),
                    Image.asset(
                      AppAssets.iconDepartment,
                      width: 40,
                      height: 40,
                    ),
                    Icon(
                      Icons.favorite,
                      color: Colors.blue.withOpacity(0.7),
                      size: 15,
                    ),
                    Image.asset(
                      AppAssets.iconMe,
                      width: 40,
                      height: 40,
                    ),
                    const SizedBox(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<String> getEmailOfCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String email = user.email!;
      print('Email của người dùng là: $email');
      return email;
    } else {
      print('Người dùng chưa đăng nhập');
      return ''; // hoặc giá trị mặc định khác tuỳ vào trường hợp
    }
  }

  void countDownTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    setState(() {
      this.isLoggedIn = isLoggedIn;
    });

    Timer(const Duration(seconds: 1), () async {
      if (isLoggedIn) {
        String email = await getEmailOfCurrentUser();
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, RoutesName.navigator, arguments: email);
        if (openTrainingPointModel?.open ??
            false ||
                (DateTime.now()
                        .difference(openTrainingPointModel?.createAt ?? DateTime.now())
                        .inDays <=
                    10)) {
          Utils.showPopup(
            context,
            icon: AppAssets.icCheck,
            title: "Chấm điểm rèn luyện đã được mở",
            message:
                "Thời gian chấm điểm rèn luyện cho học kì ${openTrainingPointModel?.semester} ${calculateRemainingTime()}",
          );
        }
      } else {
        Navigator.pushReplacementNamed(context, RoutesName.login);
      }
    });
  }

  Future<void> getOpenTrainingPoint() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await db.collection('openTrainingPoints').get();
    final List<DocumentSnapshot<Map<String, dynamic>>> documents = querySnapshot.docs;
    if (documents.isNotEmpty) {
      final OpenTrainingPointModel openTrainingPointModel =
          OpenTrainingPointModel.fromFirestore(documents.first, null);
      setState(() {
        this.openTrainingPointModel = openTrainingPointModel;
      });
    } else {
      print("no open");
    }
  }

  String calculateRemainingTime() {
    if (openTrainingPointModel?.createAt != null) {
      final now = DateTime.now().subtract(const Duration(days: 10));
      final remainingDuration = openTrainingPointModel!.createAt!.difference(now);
      final remainingDays = remainingDuration.inDays;
      final remainingHours = remainingDuration.inHours % 24;
      final remainingMinutes = remainingDuration.inMinutes % 60;

      return "\n còn $remainingDays ngày, $remainingHours giờ và $remainingMinutes phút";
    }

    return "";
  }
}
