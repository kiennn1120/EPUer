import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../res/constant/app_assets.dart';
import '../../res/style/app_colors.dart';
import '../../utils/dimens/dimens_manager.dart';
import '../../utils/general_utils.dart';
import '../../view/widgets/appbar.dart';
import '../../view/widgets/ui_outlined_button.dart';
import '../../view/widgets/ui_textinput.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({required this.email, super.key});
  final String email;
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

TextEditingController passwordController = TextEditingController();
TextEditingController newPasswordController = TextEditingController();
TextEditingController confirmPasswordController = TextEditingController();
bool isObscure = true;

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  void changePassword({required String currentPassword, required String newPassword}) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      AuthCredential credential =
          EmailAuthProvider.credential(email: widget.email, password: currentPassword);
      await user?.reauthenticateWithCredential(credential);

      await user?.updatePassword(newPassword);

      Utils.showPopup(context,
          icon: AppAssets.icCheck,
          title: "Đổi mật khẩu thành công",
          message: "Mật khẩu đã được thay đổi\n Bạn có thể đăng nhập lại bằng mật khẩu mới nhé");
    } catch (e) {
      Utils.showPopup(context,
          icon: AppAssets.icClose,
          title: "Đổi mật khẩu không thành công",
          message: "Mật khẩu cũ không chính xác");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "Đổi mật khẩu"),
      body: Container(
        color: AppColors.white,
        padding: EdgeInsets.all(DimensManager.dimens.setWidth(24)),
        child: Column(children: [
          UITextInput(
            title: "Mật khẩu hiện tại",
            controller: passwordController,
            hint: "Nhập mật khẩu",
            isObscure: isObscure,
            keyboardType: TextInputType.visiblePassword,
            onSuffixIconPressed: () => setState(() {
              isObscure = !isObscure;
            }),
          ),
          SizedBox(
            height: DimensManager.dimens.setHeight(24),
          ),
          UITextInput(
            title: "Mật khẩu mới",
            controller: newPasswordController,
            hint: "Nhập mật khẩu",
            isObscure: isObscure,
            keyboardType: TextInputType.visiblePassword,
            onSuffixIconPressed: () => setState(() {
              isObscure = !isObscure;
            }),
          ),
          SizedBox(
            height: DimensManager.dimens.setHeight(24),
          ),
          UITextInput(
            title: "Xác nhận mật khẩu",
            controller: confirmPasswordController,
            hint: "Nhập mật khẩu",
            isObscure: isObscure,
            keyboardType: TextInputType.visiblePassword,
            onSuffixIconPressed: () => setState(() {
              isObscure = !isObscure;
            }),
          ),
          SizedBox(
            height: DimensManager.dimens.setHeight(24),
          ),
          UIOutlineButton(
            backgroundColor: AppColors.primaryColor,
            title: 'Thay đổi mật khẩu',
            titleStyle: const TextStyle(color: Colors.white),
            onPressed: () {
              try {
                if (newPasswordController.text != confirmPasswordController.text) {
                  Utils.showPopup(context,
                      icon: AppAssets.icClose,
                      title: "Đổi mật khẩu không thành công",
                      message: "Mật khẩu mới và mật khẩu cũ không trùng nhau");
                  return;
                }
                changePassword(
                    currentPassword: passwordController.text,
                    newPassword: newPasswordController.text);
              } catch (e) {
                Utils.showPopup(context,
                    icon: AppAssets.icClose,
                    title: "Đổi mật khẩu không thành công",
                    message: "Mật khẩu cũ không chính xác");
              }
            },
          )
        ]),
      ),
    );
  }
}
