import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../res/constant/app_assets.dart';
import '../../res/style/app_colors.dart';
import '../../utils/dimens/dimens_manager.dart';
import '../../view/widgets/appbar.dart';
import '../../view/widgets/ui_outlined_button.dart';
import '../../view/widgets/ui_text.dart';

class MyQrScreen extends StatelessWidget {
  const MyQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, 'Mã QR cá nhân'),
      body: Container(
        color: AppColors.backgroundColor,
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              margin: EdgeInsets.all(DimensManager.dimens.setWidth(24)),
              padding: EdgeInsets.all(DimensManager.dimens.setWidth(32)),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(DimensManager.dimens.setWidth(20)),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 20, spreadRadius: 0, color: Colors.black.withOpacity(0.05))
                  ]),
              child: Column(children: [
                Row(),
                const Text(
                  'Mã QR dùng để chia sẻ thông tin cá nhân',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: DimensManager.dimens.setWidth(12),
                ),
                _qrCode(),
                const UIText(
                  "Trần Anh Quân",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: DimensManager.dimens.setHeight(34),
                ),
                _infoRow('Mã sinh viên', '1911505310144'),
                _infoRow('Lớp', '19T1'),
                _infoRow('Ngày sinh', '28/09/2001'),
                _infoRow('Ngành', 'Công Nghệ Thông Tin'),
              ]),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: DimensManager.dimens.setWidth(24)),
              child: Row(
                children: const [
                  Flexible(
                      child: UIOutlineButton(
                          title: 'Chia sẻ',
                          titleStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 16))),
                  SizedBox(
                    width: 18,
                  ),
                  Flexible(
                      child: UIOutlineButton(
                    title: 'Lưu mã QR',
                    titleStyle:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white),
                    backgroundColor: AppColors.primaryColor,
                  )),
                ],
              ),
            ),
            SizedBox(
              height: DimensManager.dimens.setHeight(53),
            )
          ]),
        ),
      ),
    );
  }

  Widget _circleAvatar() {
    return CircleAvatar(
      radius: DimensManager.dimens.setWidth(30) + 3,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: DimensManager.dimens.setWidth(30),
        backgroundImage: const AssetImage(AppAssets.avatar),
      ),
    );
  }

  Widget _qrCode() {
    return Stack(
      children: [
        QrImage(
          padding: EdgeInsets.all(DimensManager.dimens.setWidth(30)),
          //data: userModel.id,
          version: QrVersions.auto,
          size: DimensManager.dimens.setWidth(280.0),
          errorCorrectionLevel: QrErrorCorrectLevel.H, data: '',
        ),
        Positioned.fill(child: Align(alignment: Alignment.center, child: _circleAvatar()))
      ],
    );
  }

  Widget _infoRow(String title, String data) {
    return Container(
      margin: EdgeInsets.only(bottom: DimensManager.dimens.setHeight(18)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
          ),
          Flexible(
            flex: 2,
            child: Text(
              data,
              textAlign: TextAlign.right,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
