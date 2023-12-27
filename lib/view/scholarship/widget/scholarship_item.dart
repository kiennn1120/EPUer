import 'package:flutter/material.dart';

import '../../../models/scholarship_model.dart';
import '../../../res/style/app_colors.dart';
import '../../../utils/dimens/dimens_manager.dart';
import '../../../view/scholarship/widget/infor_row_widget.dart';

class ScheduleItemWidget extends StatelessWidget {
  const ScheduleItemWidget(this.schedule, {super.key});
  final ScholarshipModel schedule;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: DimensManager.dimens.setHeight(8),
          horizontal: DimensManager.dimens.setHeight(24)),
      padding: EdgeInsets.all(DimensManager.dimens.setHeight(16)),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.05))]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        SizedBox(
          height: DimensManager.dimens.setHeight(16),
        ),
        InforRowWidget(
          title: 'Mã sinh viên:',
          value: schedule.email!,
        ),
        SizedBox(
          height: DimensManager.dimens.setHeight(8),
        ),
        InforRowWidget(
          title: 'Họ tên sinh viên:',
          value: schedule.name!,
        ),
        SizedBox(
          height: DimensManager.dimens.setHeight(8),
        ),
        InforRowWidget(
          title: 'Lớp:',
          value: schedule.classRoom!,
        ),
        SizedBox(
          height: DimensManager.dimens.setHeight(8),
        ),
        InforRowWidget(
          title: 'Xếp loại học bổng:',
          value: schedule.rank!,
        ),
        SizedBox(
          height: DimensManager.dimens.setHeight(8),
        ),
        InforRowWidget(
          title: 'Số tiền:',
          value: schedule.bonus!,
        ),
        SizedBox(
          height: DimensManager.dimens.setHeight(8),
        ),
      ]),
    );
  }
}
