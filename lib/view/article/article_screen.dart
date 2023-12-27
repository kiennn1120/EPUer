import 'package:flutter/material.dart';
import '../../res/style/app_colors.dart';
import '../../utils/dimens/dimens_manager.dart';
import '../../view/widgets/appbar.dart';
import '../../view/widgets/link.dart';
import '../../view/widgets/ui_text.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, 'Các bài báo'),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: DimensManager.dimens.setHeight(22),
              horizontal: DimensManager.dimens.setWidth(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Ngày hội hiến máu diễn ra trên địa bàn thành phố Đà Nẵng",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 20, color: AppColors.primaryColor),
              ),
              SizedBox(
                height: DimensManager.dimens.setWidth(16),
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.gray),
                  ),
                  const UIText(
                    "Thứ hai - 22/08/2022 09:54",
                    fontWeight: FontWeight.w200,
                    size: 13,
                  )
                ],
              ),
              SizedBox(
                height: DimensManager.dimens.setWidth(16),
              ),
              // Content
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const UIText(
                  " Máu là món quà vô giá giúp con người duy trì sự sống. Để góp phần vào việc duy trì sự sống cho những người cần máu thì rất cần nguồn máu hiến tặng. Xuất phát từ ý nghĩa cao đẹp này, hàng năm, Công đoàn Ngành Y tế Đà Nẵng đều tổ chức Ngày hội hiến máu tình nguyện để vận động đoàn viên công đoàn trong toàn ngành tham gia hiến máu\nAnh Phan Tấn Trung - Bệnh viện Tâm Thần Đà Nẵng chia sẻ: Tôi hiến máu đến nay đã được 16 lần. Tôi nghĩ mình còn khỏe thì mình hiến máu để cứu giúp những người không may mắn. Tôi luôn xem đây là trách nhiệm và sẻ chia với những người không may mắc bệnh.",
                  style:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: AppColors.black),
                ),
                SizedBox(
                  height: DimensManager.dimens.setWidth(16),
                ),
                const LinkText(
                  text: 'Xem thêm tại đây',
                  link:
                      'https://ksbtdanang.vn/tin-tuc-su-kien/ngay-hoi-hien-mau-tinh-nguyen-nam-2022-cua-nganh-y-te-thanh-pho-da-nang-845.html',
                )
              ])
            ],
          ),
        ),
      ),
    );
  }
}
