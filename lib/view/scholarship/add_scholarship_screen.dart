import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../repository/users_repository.dart';
import '../../res/constant/app_assets.dart';
import '../../utils/dimens/dimens_manager.dart';
import '../../utils/general_utils.dart';
import '../../view/widgets/appbar.dart';
import '../../view/widgets/ui_dropdown_input.dart';
import '../../view/widgets/ui_outlined_button.dart';
import '../../view/widgets/ui_text.dart';
import '../../viewmodels/scholarship/users_viewmodel.dart';

class AddScholarshipScreen extends StatefulWidget {
  const AddScholarshipScreen({Key? key}) : super(key: key);

  @override
  _AddScholarshipScreenState createState() => _AddScholarshipScreenState();
}

class _AddScholarshipScreenState extends State<AddScholarshipScreen> {
  late UsersViewModel viewModel;
  String? mtoken = "";
  String? classRoom1;
  String? rank1;
  String? msv1;
  String? bonus1;
  String? name1;
  List<String> listMsv = [];

  @override
  void initState() {
    super.initState();
    viewModel = UsersViewModel(repository: UsersRepository())..onInitView(context);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: appBar(context, "Thêm sinh viên nhận học bổng"),
        body: Column(
          children: [
            SizedBox(
              height: DimensManager.dimens.setHeight(10),
            ),
            const UIText("HỌC KỲ I NĂM HỌC 2022-2023"),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Flexible(
                    child: UIDropdownInput(
                      title: "Lớp",
                      hint: "Chọn",
                      initValue: classRoom1,
                      list: const [
                        "19C1",
                        "19C2",
                        "19CDT1",
                        "19CDT2",
                        "19D1",
                        "19D2",
                        "19DL1",
                        "19DL2",
                        "19DT1",
                        "19HTP1",
                        "19MT1",
                        "19N1",
                        "19SK1",
                        "19SU1",
                        "19T1",
                        "19T2",
                        "19VL1",
                        "19VL2",
                      ],
                      onChanged: (String? classValue) async {
                        listMsv = await viewModel.getSearchClass(classValue ?? "");
                        listMsv.sort();
                        setState(() {
                          classRoom1 = classValue;
                          msv1 = null;
                          listMsv = listMsv;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: DimensManager.dimens.setWidth(10),
                  ),
                  Flexible(
                    child: UIDropdownInput(
                      title: "Xếp loại học bổng",
                      hint: "Chọn",
                      list: const ["Xuất Sắc", "Giỏi", "Khá"],
                      initValue: rank1,
                      onChanged: (String? rankValue) {
                        setState(() {
                          rank1 = rankValue;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Flexible(
                    child: UIDropdownInput(
                      title: "Mã sinh viên",
                      hint: "Chọn",
                      list: listMsv,
                      initValue: msv1,
                      onChanged: (String? msv) async {
                        name1 = await viewModel.getSearchName(msv!);
                        setState(() {
                          msv1 = msv;
                          name1 = name1;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: DimensManager.dimens.setWidth(10),
                  ),
                  Flexible(
                    child: UIDropdownInput(
                      title: "Số tiền",
                      hint: "Chọn",
                      initValue: rank1 == "Xuất Sắc"
                          ? bonus1 = "7.140.000"
                          : rank1 == "Giỏi"
                              ? bonus1 = "6.120.000"
                              : rank1 == "Khá"
                                  ? bonus1 = "5.100.000"
                                  : bonus1,
                      list: const ["7.140.000", "6.120.000", "5.100.000"],
                      onChanged: null,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Flexible(
                    child: UIDropdownInput(
                      title: "Tên sinh viên",
                      hint: "Chọn",
                      initValue: name1,
                      list: [name1 ?? ""],
                      onChanged: null,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: DimensManager.dimens.setHeight(20),
            ),
            Padding(
                padding: const EdgeInsets.all(15.0),
                child: UIOutlineButton(
                  title: "Thêm sinh viên",
                  onPressed: () {
                    if (bonus1 == null ||
                        classRoom1 == null ||
                        msv1 == null ||
                        name1 == null ||
                        rank1 == null) {
                      Utils.showPopup(context,
                          icon: AppAssets.icClose,
                          title: "Thêm sinh viên thất bại",
                          message: "Hãy điền đầy đủ thông tin trước khi thêm sinh viên nhé");
                      return;
                    }

                    try {
                      viewModel.addScholarship(
                        bonus: bonus1 ?? "",
                        classRoom: classRoom1 ?? "",
                        email: msv1 ?? "",
                        name: name1 ?? "",
                        rank: rank1 ?? "",
                      );
                    } catch (e) {
                      Utils.showPopup(context,
                          icon: AppAssets.icCheck,
                          title: "Thêm sinh viên thất bại",
                          message:
                              "Sinh viên đã được thêm vào rồi\nThoát ra ngoài nếu muốn xem nhé :3");
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }
}
