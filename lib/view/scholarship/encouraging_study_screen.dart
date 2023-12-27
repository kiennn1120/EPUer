import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../models/scholarship_model.dart';
import '../../repository/scholarship_repository.dart';
import '../../res/constant/app_assets.dart';
import '../../res/style/app_colors.dart';
import '../../utils/dimens/dimens_manager.dart';
import '../../utils/general_utils.dart';
import '../../utils/log_utils.dart';
import '../../view/scholarship/add_scholarship_screen.dart';
import '../../view/scholarship/widget/scholarship_item.dart';
import '../../view/widgets/appbar.dart';
import '../../view/widgets/ui_dropdown_input.dart';
import '../../view/widgets/ui_empty_png_screen.dart';
import '../../view/widgets/ui_outlined_button.dart';
import '../../view/widgets/ui_search_input.dart';
import '../../view/widgets/ui_text.dart';
import '../../viewmodels/scholarship/scholarship_viewmodel.dart';

class EncouragingStudyScreen extends StatefulWidget {
  const EncouragingStudyScreen({Key? key, required this.permission}) : super(key: key);
  final String permission;
  @override
  _EncouragingStudyScreenState createState() => _EncouragingStudyScreenState();
}

class _EncouragingStudyScreenState extends State<EncouragingStudyScreen> {
  late ScholarshipViewModel viewModel;
  String? rankDropdownValue = "Tất cả";

  String? getRankDropdownValue() {
    return rankDropdownValue;
  }

  String? classDropdownValue = "Tất cả";

  String? getClassDropdownValue() {
    return classDropdownValue;
  }

  @override
  void initState() {
    viewModel = ScholarshipViewModel(repository: ScholarshipRepository())..onInitView(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Scaffold(
        appBar: appBar(
          context,
          'Học bổng học tập',
          actions: [
            if (widget.permission == "ctsv") ...[
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddScholarshipScreen()),
                ),
              ),
              const SizedBox(
                width: 20,
              )
            ]
          ],
        ),
        body: Column(
          children: [
            Container(
                color: Colors.white,
                width: DimensManager.dimens.setWidth(390),
                height: DimensManager.dimens.setHeight(48),
                child: UISearchInput(
                  onChangeValue: (String value) => viewModel.getSearch(value.trim()),
                )),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(children: [
                Flexible(
                  child: UIDropdownInput(
                    title: "Lớp",
                    hint: "Chọn",
                    list: const [
                      "Tất cả",
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
                      "19VL2"
                    ],
                    initValue: classDropdownValue,
                    onChanged: (String? classValue) {
                      setState(() {
                        classDropdownValue = classValue;
                      });
                      String? rankValue = getRankDropdownValue();
                      if (classValue == "Tất cả" && rankValue == "Tất cả") {
                        viewModel.getScholarship();
                      } else {
                        if (rankValue == "Tất cả") {
                          viewModel.getSearchClass(classValue!);
                          return;
                        }
                        viewModel.getCombinedSearch(classValue!, rankValue!);
                      }
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
                    list: const ["Tất cả", "Xuất Sắc", "Giỏi", "Khá"],
                    initValue: rankDropdownValue,
                    onChanged: (String? rankValue) {
                      setState(() {
                        rankDropdownValue = rankValue;
                      });
                      String? classValue = getClassDropdownValue();
                      if (classValue == "Tất cả" && rankValue == "Tất cả") {
                        viewModel.getScholarship();
                      } else {
                        if (classValue == "Tất cả") {
                          viewModel.getSearchRank(rankValue!);
                          return;
                        }
                        viewModel.getCombinedSearch(classValue!, rankValue!);
                      }
                    },
                  ),
                )
              ]),
            ),
            const UIText("HỌC KỲ I NĂM HỌC 2022-2023"),
            Expanded(
              child: Selector<ScholarshipViewModel, List<ScholarshipModel>>(
                shouldRebuild: (previous, next) => true,
                selector: (_, viewModel) => viewModel.listScholarship,
                builder: (context, value, child) => viewModel.listScholarship.isNotEmpty
                    ? SlidableAutoCloseBehavior(
                        closeWhenOpened: true,
                        child: ListView.builder(
                          itemCount: viewModel.listScholarship.length,
                          itemBuilder: (context, index) {
                            final scholarship = viewModel.listScholarship[index];
                            return Slidable(
                                endActionPane: widget.permission != "ctsv"
                                    ? null
                                    : ActionPane(
                                        extentRatio: 0.2,
                                        motion: const BehindMotion(),
                                        children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: DimensManager.dimens.setWidth(12)),
                                              child: IconButton(
                                                  onPressed: () {
                                                    Utils.showPopup(
                                                      context,
                                                      icon: AppAssets.icBin,
                                                      title: 'Xoá sinh viên nhận học bổng',
                                                      message:
                                                          'Bạn có chắc chắn muốn sinh viên này không?',
                                                      action: Row(children: [
                                                        Flexible(
                                                            child: UIOutlineButton(
                                                          title: 'Huỷ',
                                                          onPressed: () =>
                                                              Navigator.of(context).pop(),
                                                        )),
                                                        SizedBox(
                                                          width: DimensManager.dimens.setWidth(16),
                                                        ),
                                                        Flexible(
                                                            child: UIOutlineButton(
                                                                title: 'Xoá',
                                                                backgroundColor:
                                                                    AppColors.primaryColor,
                                                                titleStyle: const TextStyle(
                                                                    color: Colors.white),
                                                                onPressed: () {
                                                                  viewModel.deleteDocument(
                                                                      scholarship.documentId);
                                                                  Navigator.of(context).pop();
                                                                }))
                                                      ]),
                                                    );
                                                  },
                                                  icon: SvgPicture.asset(AppAssets.icBin)),
                                            )
                                          ]),
                                child: ScheduleItemWidget(
                                    scholarship)); // your scholarship item widget
                          },
                        ),
                      )
                    : const UIEmptyPngScreen(
                        iconAsset: AppAssets.icScholarShip1,
                        title: 'Không có danh sách học bổng nào!',
                        message:
                            'Không có danh sách sinh viên nhận học bổng nào.\nVui lòng kiểm tra lại!',
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void didPopNext() {
    LogUtils.methodIn();
    viewModel.shouldOnRefreshHandler();
  }
}
