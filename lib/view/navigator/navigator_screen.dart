import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../res/constant/app_assets.dart';
import '../../res/style/app_colors.dart';
import '../../utils/dimens/dimens_manager.dart';
import '../../utils/routes/routes_name.dart';
import '../../view/chat/chat_screen.dart';
import '../../view/home/home_screen.dart';
import '../../view/notification/notification_screen.dart';
import '../../view/profile/profile_screen.dart';
import '../../view/widgets/ui_text.dart';

class NavigatorScreen extends StatefulWidget {
  final String email;

  const NavigatorScreen({Key? key, required this.email}) : super(key: key);

  @override
  NavigatorScreenState createState() => NavigatorScreenState();
}

class NavigatorScreenState extends State<NavigatorScreen> {
  Color kEnableColorButton = AppColors.requiredColor;
  Color kDisenableColorButton = Colors.white;
  Color kEnableColorIcon = AppColors.requiredColor;
  Color kDisenableColorIcon = AppColors.disableItemColor;
  Color kEnableColorText = AppColors.requiredColor;
  Color kDisenableColorText = AppColors.disableItemColor;
  int currentTab = 0;
  late List<Widget> screens;

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    super.initState();
    screens = [
      HomeScreen(email: widget.email),
      const ChatScreen(),
      NotificationScreen(email: widget.email),
      ProfileScreen(email: widget.email),
    ];
  }

  void changeCurrentTab(int value) {
    setState(() {
      currentTab = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.requiredColor,
        child: SvgPicture.asset(
          AppAssets.icQrMini,
          height: 32,
          width: 32,
        ),
        onPressed: () {
          Navigator.pushNamed(context, RoutesName.qrScanner);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: screens[currentTab],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: DimensManager.dimens.setHeight(70),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 45,
                    onPressed: () {
                      setState(() {
                        currentTab = 0;
                      });
                    },
                    child: ButtonItemNavigator(
                      currentTab: currentTab,
                      tab: 0,
                      icon: AppAssets.icHome,
                      textButton: 'Trang chủ',
                      enableColorButton: kEnableColorButton,
                      disenableColorButton: kDisenableColorButton,
                      enableColorIcon: kEnableColorIcon,
                      disenableColorIcon: kDisenableColorIcon,
                      enableColorText: kEnableColorText,
                      disenableColorText: kDisenableColorText,
                    ),
                  ),
                  MaterialButton(
                    minWidth: 45,
                    onPressed: () {
                      setState(() {
                        currentTab = 1;
                      });
                    },
                    child: ButtonItemNavigator(
                      currentTab: currentTab,
                      tab: 1,
                      icon: AppAssets.icMessage,
                      textButton: 'Tin nhắn',
                      enableColorButton: kEnableColorButton,
                      disenableColorButton: kDisenableColorButton,
                      enableColorIcon: kEnableColorIcon,
                      disenableColorIcon: kDisenableColorIcon,
                      enableColorText: kEnableColorText,
                      disenableColorText: kDisenableColorText,
                    ),
                  ),
                  //Right
                ],
              ),
              //right
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 45,
                    onPressed: () {
                      setState(() {
                        currentTab = 2;
                      });
                    },
                    child: ButtonItemNavigator(
                      currentTab: currentTab,
                      tab: 2,
                      icon: AppAssets.icNotification,
                      textButton: 'Thông báo',
                      enableColorButton: kEnableColorButton,
                      disenableColorButton: kDisenableColorButton,
                      enableColorIcon: kEnableColorIcon,
                      disenableColorIcon: kDisenableColorIcon,
                      enableColorText: kEnableColorText,
                      disenableColorText: kDisenableColorText,
                    ),
                  ),
                  MaterialButton(
                    minWidth: 45,
                    onPressed: () {
                      setState(() {
                        currentTab = 3;
                      });
                    },
                    child: ButtonItemNavigator(
                      currentTab: currentTab,
                      tab: 3,
                      icon: AppAssets.icProfile,
                      textButton: 'Tài khoản',
                      enableColorButton: kEnableColorButton,
                      disenableColorButton: kDisenableColorButton,
                      enableColorIcon: kEnableColorIcon,
                      disenableColorIcon: kDisenableColorIcon,
                      enableColorText: kEnableColorText,
                      disenableColorText: kDisenableColorText,
                    ),
                  ),
                  //Right
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonItemNavigator extends StatelessWidget {
  const ButtonItemNavigator({
    Key? key,
    required this.currentTab,
    required this.tab,
    required this.icon,
    required this.textButton,
    required this.enableColorButton,
    required this.disenableColorButton,
    required this.enableColorIcon,
    required this.disenableColorIcon,
    required this.enableColorText,
    required this.disenableColorText,
  }) : super(key: key);

  final int currentTab;
  final int tab;
  final String icon;
  final String textButton;
  final Color enableColorButton;
  final Color disenableColorButton;
  final Color enableColorIcon;
  final Color disenableColorIcon;
  final Color enableColorText;
  final Color disenableColorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: DimensManager.dimens.setHeight(4),
          width: DimensManager.dimens.setWidth(45),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            color: currentTab == tab ? enableColorButton : disenableColorButton,
          ),
        ),
        SvgPicture.asset(
          icon,
          color: currentTab == tab ? enableColorIcon : disenableColorIcon,
        ),
        UIText(textButton,
            style: TextStyle(
                fontSize: DimensManager.dimens.setSp(10),
                color: currentTab == tab ? enableColorText : disenableColorText,
                fontWeight: FontWeight.w700)),
        SizedBox(
          height: DimensManager.dimens.setHeight(10),
        )
      ],
    );
  }
}
