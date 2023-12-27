import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../res/constant/app_assets.dart';
import '../../res/style/app_colors.dart';
import '../../utils/dimens/dimens_manager.dart';
import '../../view/widgets/appbar.dart';
import '../../view/widgets/ui_dropdown_input.dart';
import '../../view/widgets/ui_outlined_button.dart';
import '../../view/widgets/ui_text_button.dart';
import '../../view/widgets/ui_textinput.dart';

const kPadding = 24.0;
const kPaddingHorizontal = 12.0;
const kPaddingVertical = 24.0;

class ProfileDetailScreen extends StatefulWidget {
  const ProfileDetailScreen({required this.email, super.key});
  final String email;

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context, 'Thông tin tài khoản'),
        body: Container(
            color: Colors.white,
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  padding: const EdgeInsets.all(kPadding),
                  child: Column(children: [
                    Row(
                      children: [
                        _buildAvatar(),
                        SizedBox(
                          width: DimensManager.dimens.setWidth(kPaddingVertical),
                        ),
                        const UITextButton(
                          text: 'Tải ảnh mới',
                          color: AppColors.gray,
                          // onPressed: _viewModel.pickImageFromGallery,
                        ),
                        SizedBox(
                          width: DimensManager.dimens.setWidth(16),
                        ),
                        const UITextButton(
                          text: 'Xoá',
                          //  onPressed: _viewModel.clearAvatar,
                        )
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: kPaddingVertical),
                      child: Column(children: [
                        UITextInput(
                          controller: TextEditingController(text: user?.name),
                          title: "Họ và tên",
                          isRequired: true,
                          hint: "Nhập tên của bạn",
                          isObscure: false,
                          enabled: false,
                          onChanged: null,
                        ),
                        SizedBox(
                          height: DimensManager.dimens.setHeight(kPaddingVertical),
                        ),
                        Row(
                          children: [
                            const Flexible(
                              child: UIDropdownInput(
                                title: "Lớp",
                                isRequired: true,
                                hint: "Chọn",
                                list: ["19T1"],
                                initValue: "19T1",
                                // onChanged: (String? val) {
                                //   if (val != null) {
                                //     _viewModel.userModel.gender = val;
                                //   }
                                // },
                              ),
                            ),
                            SizedBox(
                              width: DimensManager.dimens.setWidth(kPaddingHorizontal),
                            ),
                            const Flexible(
                              child: UIDropdownInput(
                                title: "Giới tính",
                                isRequired: true,
                                hint: "Chọn",
                                list: ["Nam", "Nữ", "Khác"],
                                initValue: "Nam",
                                // onChanged: (String? val) {
                                //   if (val != null) {
                                //     _viewModel.userModel.gender = val;
                                //   }
                                // },
                              ),
                            ),
                            SizedBox(
                              width: DimensManager.dimens.setWidth(kPaddingHorizontal),
                            ),
                            const Flexible(
                              child: UITextInput(
                                enabled: false,
                                title: "Ngày sinh",
                                isRequired: true,
                                hint: "28/09/2001",
                                // controller:
                                //     TextEditingController(text: 'ấ'),
                                // onChanged: (String val) {
                                //   _viewModel.userModel.birthYear = val;
                                // },
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: DimensManager.dimens.setHeight(kPaddingVertical),
                        ),

                        UITextInput(
                          controller: TextEditingController(text: user?.msv),
                          numberType: true,
                          title: "Mã sinh viên",
                          isRequired: true,
                          hint: "Nhập mã sinh viên của bạn",
                          isObscure: false,
                          enabled: false,
                          //   onChanged: _viewModel.onCitizenIdChanged,
                          //   errorMessage: StringUtils.toInvalidCitizenIdString(state, context),
                          // ),
                        ),
                        SizedBox(
                          height: DimensManager.dimens.setHeight(kPaddingVertical),
                        ),
                        UITextInput(
                          controller: TextEditingController(text: '0901929194'), enabled: false,
                          numberType: true,
                          title: "Số điện thoại",
                          isRequired: true,
                          hint: "Nhập số điện thoại của bạn",
                          isObscure: false,
                          //   onChanged: _viewModel.onPhoneChanged,
                          //   errorMessage: StringUtils.toInvalidPhoneString(state, context),
                          // ),
                        ),

                        SizedBox(
                          height: DimensManager.dimens.setHeight(kPaddingVertical),
                        ),
                        UITextInput(
                          controller: TextEditingController(text: user?.email),
                          enabled: false,
                          title: "Email",
                          isRequired: true,
                          hint: "Nhập email của bạn",
                          isObscure: false,

                          //   onChanged: _viewModel.onEmailChanged,
                          //   errorMessage: StringUtils.toInvalidEmailString(state, context),
                          // ),
                        ),
                        SizedBox(
                          height: DimensManager.dimens.setHeight(kPaddingVertical),
                        ),
                        const UIDropdownInput(
                            title: "Khoa",
                            hint: '',
                            isRequired: true,
                            list: ['Công Nghệ Số'],
                            initValue: 'Công Nghệ Số'
                            // onChanged: _viewModel.onCityChanged,
                            ),

                        SizedBox(
                          height: DimensManager.dimens.setHeight(kPaddingVertical),
                        ),
                        const UIDropdownInput(
                          title: "Ngành",
                          isRequired: true,
                          hint: '',
                          list: ["Công Nghệ Thông Tin"],
                          initValue: "Công Nghệ Thông Tin",
                          // onChanged: _viewModel.onDistrictChanged,
                        ),

                        SizedBox(
                          height: DimensManager.dimens.setHeight(kPaddingVertical),
                        ),
                        //      UIDropdownInput(
                        //           title: "Phường/Xã",
                        //           isRequired: false,
                        //           hint: _viewModel.userModel.addressWard.isNotEmpty
                        //               ? _viewModel.userModel.addressWard
                        //               : "Chọn",
                        //           list: wards,
                        //           onChanged: _viewModel.onWardChanged,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        const UIOutlineButton(
                          backgroundColor: AppColors.primaryColor,
                          title: "Cập nhật thông tin",
                          titleStyle: TextStyle(color: Colors.white),
                          // onPressed: () {
                          //   _viewModel.updateUserInformation();
                          // },
                        )
                      ]),
                    ),
                  ]),
                ),
              ),
            )));
  }

  Widget _buildAvatar() {
    return Container(
      width: DimensManager.dimens.setWidth(100),
      height: DimensManager.dimens.setWidth(100),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          image: DecorationImage(image: AssetImage(AppAssets.avatar), fit: BoxFit.cover)),
    );
  }
}
