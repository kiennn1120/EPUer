import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/open_training_point_model.dart';
import '../../res/constant/app_assets.dart';
import '../../utils/general_utils.dart';
import '../../utils/routes/routes.dart';
import '../../utils/routes/routes_name.dart';
import '../../view/constant/ui_text_styles.dart';
import '../../view/widgets/button.dart';
import '../../view/widgets/ui_textinput.dart';

import '../widgets/header/auth_header.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isObscure = true;
  OpenTrainingPointModel? openTrainingPointModel;

  @override
  void initState() {
    super.initState();
    getOpenTrainingPoint();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AuthHeader(
              title: 'Đăng Nhập',
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 15, bottom: 2),
                    child: Text(
                      'Tài khoản',
                      style: UITextStyles.textBlack,
                    ),
                  ),
                  UITextInput(
                    controller: emailController,
                    hint: 'example@sv.ute.udn.vn',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 15, bottom: 2),
                    child: Text(
                      'Mật khẩu',
                      style: UITextStyles.textBlack,
                    ),
                  ),
                  UITextInput(
                    controller: passwordController,
                    hint: 'example123@',
                    isObscure: isObscure,
                    keyboardType: TextInputType.visiblePassword,
                    onSuffixIconPressed: () => setState(() {
                      isObscure = !isObscure;
                    }),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  BasicButton(
                    text: 'Đăng nhập',
                    onPressed: () async {
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: emailController.text.toString().trim(),
                          password: passwordController.text.toString().trim(),
                        );
                        if (!mounted) return;
                        Routes.goToNavigatorScreen(context,
                            arguments: emailController.text.toString().trim());
                        if (openTrainingPointModel?.open ??
                            false ||
                                (DateTime.now()
                                        .difference(
                                            openTrainingPointModel?.createAt ?? DateTime.now())
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
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('isLoggedIn', true);

                        emailController.text = "";
                        passwordController.text = "";
                      } catch (e) {
                        Utils.showPopup(
                          context,
                          icon: AppAssets.icClose,
                          title: "Đăng nhập không thành công",
                          message: "Tài khoản hoặc mật khẩu không chính xác",
                        );
                      }
                    },
                  ),
                  Center(
                    child: BackTextButton(
                      text: "Quên mật khẩu?",
                      onPressed: () {
                        Navigator.pushNamed(context, RoutesName.forgotPassword);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
