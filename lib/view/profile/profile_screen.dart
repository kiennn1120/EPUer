import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user_model.dart';
import '../../res/constant/app_assets.dart';
import '../../res/style/app_colors.dart';
import '../../utils/dimens/dimens_manager.dart';
import '../../utils/general_utils.dart';
import '../../utils/routes/routes.dart';
import '../../utils/routes/routes_name.dart';
import '../../view/chart/pie_chart.dart';
import '../../view/widgets/ui_outlined_button.dart';
import '../../view/widgets/ui_text.dart';

const kIconSize = 24.0;
const kBorderRadius = 50.0;

class ProfileScreen extends StatefulWidget {
  final String email;
  const ProfileScreen({super.key, required this.email});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UsersModel? user;

  @override
  void initState() {
    super.initState();
    getUser(widget.email);
  }

  Future<void> getUser(String email) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await db.collection('users').where('email', isEqualTo: email).get();
    final List<DocumentSnapshot<Map<String, dynamic>>> documents = querySnapshot.docs;
    if (documents.isNotEmpty) {
      final UsersModel user = UsersModel.fromFirestore(documents.first, null);
      setState(() {
        this.user = user;
      });
    } else {
      print('No user found with email: $email');
    }
  }

  void _confirmSignout(BuildContext context) {
    Utils.showPopup(
      context,
      icon: AppAssets.icSignOutRed,
      title: 'Đăng xuất',
      message: 'Bạn có chắc chắn muốn đăng xuất tài khoản?',
      action: Row(children: [
        Flexible(
            child: UIOutlineButton(
          title: 'Huỷ',
          onPressed: () => Navigator.of(context).pop(),
        )),
        SizedBox(
          width: DimensManager.dimens.setWidth(16),
        ),
        Flexible(
            child: UIOutlineButton(
                title: 'Đăng xuất',
                backgroundColor: AppColors.primaryColor,
                titleStyle: const TextStyle(color: Colors.white),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  if (!mounted) return;
                  Routes.goToLoginScreen(context);
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('isLoggedIn', false);
                }))
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.white,
        child: Column(children: [
          Container(
            decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(kBorderRadius),
                    bottomRight: Radius.circular(kBorderRadius))),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SafeArea(
                  bottom: false,
                  child: SizedBox(
                    height: DimensManager.dimens.setHeight(20),
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(),
                  _circleAvatar(AppAssets.avatar),
                  SizedBox(
                    height: DimensManager.dimens.setHeight(16),
                  ),
                  UIText(
                    user?.name ?? "",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                  UIText(
                    user?.msv ?? "",
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 12, color: Colors.white),
                  ),
                  SizedBox(
                    height: DimensManager.dimens.setHeight(12),
                  ),
                  UIText(
                    user?.major ?? "",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 12, color: Colors.white),
                  ),
                  UIText(
                    user?.department ?? "",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 12, color: Colors.white),
                  ),
                  SizedBox(
                    height: DimensManager.dimens.setHeight(12),
                  ),
                ],
              )
            ]),
          ),
          Expanded(
              child: Column(
            children: [
              _profileItem(AppAssets.icUser, 'Thông tin tài khoản', onTap: () {
                Navigator.pushNamed(context, RoutesName.profileDetail, arguments: widget.email);
              }),
              _profileItem(AppAssets.icQr, 'Mã QR cá nhân', onTap: () {
                Navigator.pushNamed(context, RoutesName.myQr);
              }),
              _profileItem(AppAssets.icPassword, 'Đổi mật khẩu', onTap: () {
                Navigator.pushNamed(context, RoutesName.changePassword, arguments: widget.email);
              }),
              _profileItem(AppAssets.icSupport, 'Liên hệ', onTap: () {
                Navigator.pushNamed(context, RoutesName.contact);

                // CollectionReference users = FirebaseFirestore.instance.collection('trainingPoints');
                // users
                //     .add({
                //       'activate1': 0,
                //       'activate2': 0,
                //       'activate3': 0,
                //       'activate4': 0,
                //       'monitor1': 0,
                //       'monitor2': 0,
                //       'monitor3': 0,
                //       'monitor4': 0,
                //       'relation1': 0,
                //       'relation2': 0,
                //       'relation3': 0,
                //       'relation4': 0,
                //       'relation5': 0,
                //       'rules1': 0,
                //       'rules2': 0,
                //       'rules3': 0,
                //       'rules4': 0,
                //       'study1': 0,
                //       'study2': 0,
                //       'study3': 0,
                //       'study4': 0,
                //       'study5': 0,
                //       'study6': 0,
                //       'trainingPoint': 0,
                //       'trainingPoint1': 0,
                //       'trainingPoint2': 0,
                //       'trainingPoint3': 0,
                //       'trainingPoint4': 0,
                //       'trainingPoint5': 0,
                //       'gvcn': "Cô chủ nhiệm 19T1",
                //       'rank': "Kém",
                //       'email': "1911505310144@sv.ute.udn.vn",
                //       'history': false,
                //       'teacherActivate1': 0,
                //       'teacherActivate2': 0,
                //       'teacherActivate3': 0,
                //       'teacherActivate4': 0,
                //       'teacherMonitor1': 0,
                //       'teacherMonitor2': 0,
                //       'teacherMonitor3': 0,
                //       'teacherMonitor4': 0,
                //       'teacherRelation1': 0,
                //       'teacherRelation2': 0,
                //       'teacherRelation3': 0,
                //       'teacherRelation4': 0,
                //       'teacherRelation5': 0,
                //       'teacherRules1': 0,
                //       'teacherRules2': 0,
                //       'teacherRules3': 0,
                //       'teacherRules4': 0,
                //       'teacherStudy1': 0,
                //       'teacherStudy2': 0,
                //       'teacherStudy3': 0,
                //       'teacherStudy4': 0,
                //       'teacherStudy5': 0,
                //       'teacherStudy6': 0,
                //       'teacherTrainingPoint': 0,
                //       'teacherTrainingPoint1': 0,
                //       'teacherTrainingPoint2': 0,
                //       'teacherTrainingPoint3': 0,
                //       'teacherTrainingPoint4': 0,
                //       'teacherTrainingPoint5': 0,
                //       'teacherRank': "Kém",
                //       'status': false,
                //       'semester': "122",
                //     })
                //     .then((value) => print('User added'))
                //     .catchError((error) => print('Failed to add user: $error'));
              }),
              if (user?.permission == "ctsv")
                _profileItem(AppAssets.icChart, 'Thống kê', onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PieChartScholarship()),
                  );
                  //   CollectionReference users = FirebaseFirestore.instance.collection('users');
                  //   users
                  //       .add({
                  //         "msv": "1911505310169",
                  //         "name": "Nguyễn Hoàng Việt",
                  //         "classRoom": "19T1",
                  //         "email": "1911505310169@sv.ute.udn.vn",
                  //         'major': 'Công nghệ thông tin',
                  //         'department': 'Công nghệ số',
                  //         'phone': '0901929194',
                  //         'permission': 'student',
                  //       })
                  //       .then((value) => print('User added'))
                  //       .catchError((error) => print('Failed to add user: $error'));
                }),
              _profileItem(AppAssets.icSignOut, 'Đăng xuất', onTap: () {
                _confirmSignout(context);
              }),
            ],
          ))
        ]),
      ),
    );
  }

  Widget _circleAvatar(String? url) {
    return CircleAvatar(
      radius: DimensManager.dimens.setWidth(kBorderRadius) + 3,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: DimensManager.dimens.setWidth(kBorderRadius),
        backgroundImage: const AssetImage(AppAssets.avatar),
      ),
    );
  }

  Widget _profileItem(String icon, String title, {void Function()? onTap}) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: DimensManager.dimens.setHeight(16),
              horizontal: DimensManager.dimens.setWidth(24)),
          child: Row(
            children: [
              SvgPicture.asset(
                icon,
                width: DimensManager.dimens.setWidth(kIconSize),
                height: kIconSize,
                color: AppColors.inFieldTextColor,
              ),
              const SizedBox(
                width: kIconSize,
              ),
              UIText(
                title,
                size: DimensManager.dimens.setSp(15),
                color: AppColors.headerTextColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
