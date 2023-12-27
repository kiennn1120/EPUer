import 'package:flutter/material.dart';
import '../../res/style/app_colors.dart';
import '../../utils/dimens/dimens_manager.dart';
import '../../view/widgets/appbar.dart';
import '../../view/widgets/ui_text.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "Liên hệ"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: DimensManager.dimens.setHeight(24)),
          Center(
            child: UIText(
              'Phòng Công tác Sinh viên',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: DimensManager.dimens.setSp(20),
                color: AppColors.contentTextColor,
              ),
            ),
          ),
          SizedBox(height: DimensManager.dimens.setHeight(24)),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UIText(
                  'Điện thoại: 0236.3896602',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: DimensManager.dimens.setSp(15),
                    color: AppColors.contentTextColor,
                  ),
                ),
                UIText(
                  'Email: ​phongctsv@ute.udn.vn',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: DimensManager.dimens.setSp(15),
                    color: AppColors.contentTextColor,
                  ),
                ),
                SizedBox(height: DimensManager.dimens.setHeight(10)),
                UIText(
                  '• ThS. Nguyễn Tấn Hòa',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: DimensManager.dimens.setSp(18),
                    color: AppColors.contentTextColor,
                  ),
                ),
                SizedBox(height: DimensManager.dimens.setHeight(5)),
                UIText(
                  'Trưởng phòng',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: DimensManager.dimens.setSp(15),
                    color: AppColors.contentTextColor,
                  ),
                ),
                UIText(
                  'Điện thoại: (84) 0236.3896602',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: DimensManager.dimens.setSp(15),
                    color: AppColors.contentTextColor,
                  ),
                ),
                UIText(
                  'Email: nthoa@ute.udn.vn',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: DimensManager.dimens.setSp(15),
                    color: AppColors.contentTextColor,
                  ),
                ),
                SizedBox(height: DimensManager.dimens.setHeight(10)),
                UIText(
                  '• ThS. Nguyễn Hữu Thành',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: DimensManager.dimens.setSp(18),
                    color: AppColors.contentTextColor,
                  ),
                ),
                SizedBox(height: DimensManager.dimens.setHeight(5)),
                UIText(
                  'Phó Trưởng phòng',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: DimensManager.dimens.setSp(15),
                    color: AppColors.contentTextColor,
                  ),
                ),
                UIText(
                  'Điện thoại: (84) 0236.3896602',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: DimensManager.dimens.setSp(15),
                    color: AppColors.contentTextColor,
                  ),
                ),
                UIText(
                  'Email: nhthanh@ute.udn.vn',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: DimensManager.dimens.setSp(15),
                    color: AppColors.contentTextColor,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
