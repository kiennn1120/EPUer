import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/open_training_point_model.dart';
import '../../models/training_point_model.dart';
import '../../repository/training_point_repository.dart';
import '../../res/constant/app_assets.dart';
import '../../res/style/app_colors.dart';
import '../../utils/dimens/dimens_manager.dart';
import '../../utils/general_utils.dart';
import '../../view/widgets/appbar.dart';
import '../../view/widgets/ui_empty_png_screen.dart';
import '../../view/widgets/ui_outlined_button.dart';
import '../../view/widgets/ui_text.dart';
import '../../viewmodels/training_point/training_point_viewmodel.dart';

class TrainingPointsScreen extends StatefulWidget {
  final String email;
  final bool absorbing;

  const TrainingPointsScreen({Key? key, required this.email, required this.absorbing})
      : super(key: key);

  @override
  _TrainingPointsScreenState createState() => _TrainingPointsScreenState();
}

class _TrainingPointsScreenState extends State<TrainingPointsScreen> {
  late TrainingPointViewModel viewModel;
  late String email;
  bool isLoading = true;
  @override
  void initState() {
    viewModel = TrainingPointViewModel(repository: TrainingPointRepository())..onInitView(context);
    super.initState();

    viewModel.getTrainingPoint(widget.email, "222");
    viewModel.getOpenTrainingPoint();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: appBar(context, 'Tự đánh giá điểm rèn luyện'),
          body: isLoading
              ? _buildLoadingIndicator()
              : Selector<TrainingPointViewModel, OpenTrainingPointModel?>(
                  selector: (_, viewModel) => viewModel.openTrainingPoint,
                  builder: (context, value, child) {
                    final isOpen = value?.open ?? false;
                    return isOpen
                        ? SingleChildScrollView(
                            child: AbsorbPointer(
                              absorbing: widget.absorbing,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    const _TitleTrainingPoint(
                                      title: "I. ĐÁNH GIÁ VỀ Ý THỨC THAM GIA HỌC TẬP (20 điểm)",
                                    ),
                                    Selector<TrainingPointViewModel, TrainingPointModel?>(
                                      selector: (_, viewModel) => viewModel.trainingPoint,
                                      builder: (context, value, child) => _DescriptionTrainingPoint(
                                        email: widget.email,
                                        description:
                                            'Có đi học chuyên cần, đúng giờ, nghiêm túc trong giờ học; đủ điều kiện dự thi tất cả các học phần. (4 điểm)',
                                        onScoreChanged: (score) => viewModel.updateDocument(
                                          semester: '222',
                                          documentID: viewModel.trainingPoint?.documentId ?? "",
                                          key: "study1",
                                          value: score,
                                          email: widget.email,
                                        ),
                                        scoreT: 4,
                                        score: viewModel.trainingPoint?.study1 ?? 0,
                                        viewModel: viewModel,
                                      ),
                                    ),
                                    Selector<TrainingPointViewModel, TrainingPointModel?>(
                                      selector: (_, viewModel) => viewModel.trainingPoint,
                                      builder: (context, value, child) => _DescriptionTrainingPoint(
                                        email: widget.email,
                                        description:
                                            'Có ý thức tham gia các câu lạc bộ học thuật, các hoạt động học thuật, hoạt động ngoại khóa.	(2 điểm)',
                                        onScoreChanged: (score) => viewModel.updateDocument(
                                            semester: '222',
                                            documentID: viewModel.trainingPoint?.documentId ?? "",
                                            key: "study2",
                                            value: score,
                                            email: widget.email),
                                        scoreT: 2,
                                        score: viewModel.trainingPoint?.study2 ?? 0,
                                        viewModel: viewModel,
                                      ),
                                    ),
                                    Selector<TrainingPointViewModel, TrainingPointModel?>(
                                      selector: (_, viewModel) => viewModel.trainingPoint,
                                      builder: (context, value, child) => _DescriptionTrainingPoint(
                                        email: widget.email,
                                        description:
                                            'Có đăng ký, thực hiện, báo cáo đề tài NCKH đúng tiến độ hoặc đăng ký, tham dự kỳ thi sinh viên giỏi các cấp. (2 điểm)',
                                        onScoreChanged: (score) => viewModel.updateDocument(
                                          semester: '222',
                                          documentID: viewModel.trainingPoint?.documentId ?? "",
                                          key: "study3",
                                          value: score,
                                          email: widget.email,
                                        ),
                                        scoreT: 2,
                                        score: viewModel.trainingPoint?.study3 ?? 0,
                                        viewModel: viewModel,
                                      ),
                                    ),
                                    Selector<TrainingPointViewModel, TrainingPointModel?>(
                                      selector: (_, viewModel) => viewModel.trainingPoint,
                                      builder: (context, value, child) => _DescriptionTrainingPoint(
                                        email: widget.email,
                                        description:
                                            'Không vi phạm quy chế thi và kiểm tra. (6 điểm)',
                                        onScoreChanged: (score) => viewModel.updateDocument(
                                            semester: '222',
                                            documentID: viewModel.trainingPoint?.documentId ?? "",
                                            key: "study4",
                                            value: score,
                                            email: widget.email),
                                        scoreT: 6,
                                        score: viewModel.trainingPoint?.study4 ?? 0,
                                        viewModel: viewModel,
                                      ),
                                    ),
                                    Selector<TrainingPointViewModel, TrainingPointModel?>(
                                      selector: (_, viewModel) => viewModel.trainingPoint,
                                      builder: (context, value, child) => _DescriptionTrainingPoint(
                                        email: widget.email,
                                        description:
                                            'Được tập thể lớp công nhận có tinh thần vượt khó, phấn đấu vươn lên trong học tập.(2 điểm)',
                                        onScoreChanged: (score) => viewModel.updateDocument(
                                            semester: '222',
                                            documentID: viewModel.trainingPoint?.documentId ?? "",
                                            key: "study5",
                                            value: score,
                                            email: widget.email),
                                        scoreT: 2,
                                        score: viewModel.trainingPoint?.study5 ?? 0,
                                        viewModel: viewModel,
                                      ),
                                    ),
                                    Selector<TrainingPointViewModel, TrainingPointModel?>(
                                      selector: (_, viewModel) => viewModel.trainingPoint,
                                      builder: (context, value, child) => RadioListTile(
                                        title: const Text('ĐTBCHK từ 3,2 đến 4,0 (4 điểm)'),
                                        value: 4,
                                        groupValue: viewModel.trainingPoint?.study6,
                                        onChanged: (score) {
                                          viewModel.updateDocument(
                                              semester: '222',
                                              documentID: viewModel.trainingPoint?.documentId ?? "",
                                              key: "study6",
                                              value: score ?? 0,
                                              email: widget.email);
                                        },
                                      ),
                                    ),
                                    Selector<TrainingPointViewModel, TrainingPointModel?>(
                                      selector: (_, viewModel) => viewModel.trainingPoint,
                                      builder: (context, value, child) => RadioListTile(
                                        title: const Text('ĐTBCHK từ 2,0 đến 3,19 (2 điểm)'),
                                        value: 2,
                                        groupValue: viewModel.trainingPoint?.study6,
                                        onChanged: (score) {
                                          viewModel.updateDocument(
                                              semester: '222',
                                              documentID: viewModel.trainingPoint?.documentId ?? "",
                                              key: "study6",
                                              value: score ?? 0,
                                              email: widget.email);
                                        },
                                      ),
                                    ),
                                    Selector<TrainingPointViewModel, TrainingPointModel?>(
                                      selector: (_, viewModel) => viewModel.trainingPoint,
                                      builder: (context, value, child) => RadioListTile(
                                        title: const Text('ĐTBCHK dưới 2,0 (0 điểm)'),
                                        value: 0,
                                        groupValue: viewModel.trainingPoint?.study6,
                                        onChanged: (score) {
                                          viewModel.updateDocument(
                                              semester: '222',
                                              documentID: viewModel.trainingPoint?.documentId ?? "",
                                              key: "study6",
                                              value: score ?? 0,
                                              email: widget.email);
                                        },
                                      ),
                                    ),
                                    Consumer<TrainingPointViewModel>(
                                      builder: (context, viewModel, child) {
                                        final trainingPoint = viewModel.trainingPoint;
                                        final sumStudyPoints = (trainingPoint?.study1 ?? 0) +
                                            (trainingPoint?.study2 ?? 0) +
                                            (trainingPoint?.study3 ?? 0) +
                                            (trainingPoint?.study4 ?? 0) +
                                            (trainingPoint?.study5 ?? 0) +
                                            (trainingPoint?.study6 ?? 0); // Include study6 score
                                        return _SumGrade(
                                          description: "Cộng mục I:",
                                          sumTraningPoint: sumStudyPoints,
                                        );
                                      },
                                    ),
                                    const _TitleTrainingPoint(
                                      title:
                                          "II. ĐÁNH GIÁ VỀ Ý THỨC CHẤP HÀNH NỘI QUY, QUY CHẾ TRONG NHÀ TRƯỜNG (25 điểm)",
                                    ),
                                    Selector<TrainingPointViewModel, TrainingPointModel?>(
                                      selector: (_, viewModel) => viewModel.trainingPoint,
                                      builder: (context, value, child) => _DescriptionTrainingPoint(
                                        email: widget.email,
                                        description:
                                            'Có ý thức chấp hành các văn bản chỉ đạo của ngành, cấp trên và ĐHĐN được thực hiện trong nhà trường. (6 điểm)',
                                        onScoreChanged: (score) => viewModel.updateDocument(
                                            semester: '222',
                                            documentID: viewModel.trainingPoint?.documentId ?? "",
                                            key: "rules1",
                                            value: score,
                                            email: widget.email),
                                        scoreT: 6,
                                        score: viewModel.trainingPoint?.rules1 ?? 0,
                                        viewModel: viewModel,
                                      ),
                                    ),
                                    Selector<TrainingPointViewModel, TrainingPointModel?>(
                                      selector: (_, viewModel) => viewModel.trainingPoint,
                                      builder: (context, value, child) => _DescriptionTrainingPoint(
                                        email: widget.email,
                                        description:
                                            'Có ý thức tham gia đầy đủ, đạt yêu cầu các cuộc vận động, sinh hoạt chính trị theo chủ trương, của cấp trên, ĐHĐN và nhà trường. \n(4 điểm)',
                                        onScoreChanged: (score) => viewModel.updateDocument(
                                            semester: '222',
                                            documentID: viewModel.trainingPoint?.documentId ?? "",
                                            key: "rules2",
                                            value: score,
                                            email: widget.email),
                                        scoreT: 4,
                                        score: viewModel.trainingPoint?.rules2 ?? 0,
                                        viewModel: viewModel,
                                      ),
                                    ),
                                    Selector<TrainingPointViewModel, TrainingPointModel?>(
                                      selector: (_, viewModel) => viewModel.trainingPoint,
                                      builder: (context, value, child) => _DescriptionTrainingPoint(
                                        email: widget.email,
                                        description:
                                            'Có ý thức chấp hành nội quy, quy chế và các quy định của nhà trường. (10 điểm)',
                                        onScoreChanged: (score) => viewModel.updateDocument(
                                            semester: '222',
                                            documentID: viewModel.trainingPoint?.documentId ?? "",
                                            key: "rules3",
                                            value: score,
                                            email: widget.email),
                                        scoreT: 10,
                                        score: viewModel.trainingPoint?.rules3 ?? 0,
                                        viewModel: viewModel,
                                      ),
                                    ),
                                    Selector<TrainingPointViewModel, TrainingPointModel?>(
                                      selector: (_, viewModel) => viewModel.trainingPoint,
                                      builder: (context, value, child) => _DescriptionTrainingPoint(
                                        email: widget.email,
                                        description:
                                            'Đóng học phí và các khoản thu khác đầy đủ, đúng hạn. (5 điểm)',
                                        onScoreChanged: (score) => viewModel.updateDocument(
                                            semester: '222',
                                            documentID: viewModel.trainingPoint?.documentId ?? "",
                                            key: "rules4",
                                            value: score,
                                            email: widget.email),
                                        scoreT: 5,
                                        score: viewModel.trainingPoint?.rules4 ?? 0,
                                        viewModel: viewModel,
                                      ),
                                    ),
                                    Consumer<TrainingPointViewModel>(
                                      builder: (context, viewModel, child) {
                                        final trainingPoint = viewModel.trainingPoint;
                                        final sumStudyPoints = (trainingPoint?.rules1 ?? 0) +
                                            (trainingPoint?.rules2 ?? 0) +
                                            (trainingPoint?.rules3 ?? 0) +
                                            (trainingPoint?.rules4 ?? 0); // Include study6 score
                                        return _SumGrade(
                                          description: "Cộng mục II:",
                                          sumTraningPoint: sumStudyPoints,
                                        );
                                      },
                                    ),
                                    const _TitleTrainingPoint(
                                      title:
                                          "III. ĐÁNH GIÁ VỀ Ý THỨC THAM GIA CÁC HOẠT ĐỘNG CHÍNH TRỊ- XÃ HỘI, VHVN, TDTT, PHÒNG CHỐNG TỘI PHẠM VÀ CÁC TỆ NẠN XÃ HỘI (20 điểm)",
                                    ),
                                    Selector<TrainingPointViewModel, TrainingPointModel?>(
                                      selector: (_, viewModel) => viewModel.trainingPoint,
                                      builder: (context, value, child) => _DescriptionTrainingPoint(
                                        email: widget.email,
                                        description:
                                            'Tham gia đầy đủ, đạt yêu cầu “ Tuần sinh hoạt công dân sinh viên” đầu khóa năm học và cuối khóa.(10 điểm)',
                                        onScoreChanged: (score) => viewModel.updateDocument(
                                            semester: '222',
                                            documentID: viewModel.trainingPoint?.documentId ?? "",
                                            key: "activate1",
                                            value: score,
                                            email: widget.email),
                                        scoreT: 10,
                                        score: viewModel.trainingPoint?.activate1 ?? 0,
                                        viewModel: viewModel,
                                      ),
                                    ),
                                    Selector<TrainingPointViewModel, TrainingPointModel?>(
                                      selector: (_, viewModel) => viewModel.trainingPoint,
                                      builder: (context, value, child) => _DescriptionTrainingPoint(
                                        email: widget.email,
                                        description:
                                            'Có ý thức tham gia đầy đủ, nghiêm túc hoạt động rèn luyện về chính trị, xã hội, văn hóa, văn nghệ, thể thao do nhà trường và ĐHĐN tổ chức, điều động.(6 điểm)',
                                        onScoreChanged: (score) => viewModel.updateDocument(
                                            semester: '222',
                                            documentID: viewModel.trainingPoint?.documentId ?? "",
                                            key: "activate2",
                                            value: score,
                                            email: widget.email),
                                        scoreT: 6,
                                        score: viewModel.trainingPoint?.activate2 ?? 0,
                                        viewModel: viewModel,
                                      ),
                                    ),
                                    Selector<TrainingPointViewModel, TrainingPointModel?>(
                                      selector: (_, viewModel) => viewModel.trainingPoint,
                                      builder: (context, value, child) => _DescriptionTrainingPoint(
                                        email: widget.email,
                                        description:
                                            'Có ý thức tham gia các hoạt động công ích, tình nguyện, công tác xã hội trong nhà trường.	(2 điểm)',
                                        onScoreChanged: (score) => viewModel.updateDocument(
                                            semester: '222',
                                            documentID: viewModel.trainingPoint?.documentId ?? "",
                                            key: "activate3",
                                            value: score,
                                            email: widget.email),
                                        scoreT: 2,
                                        score: viewModel.trainingPoint?.activate3 ?? 0,
                                        viewModel: viewModel,
                                      ),
                                    ),
                                    Selector<TrainingPointViewModel, TrainingPointModel?>(
                                      selector: (_, viewModel) => viewModel.trainingPoint,
                                      builder: (context, value, child) => _DescriptionTrainingPoint(
                                        email: widget.email,
                                        description:
                                            'Có ý thức tuyên truyền, phòng chống tội phạm và các tệ nạn xã hội.(2 điểm)',
                                        onScoreChanged: (score) => viewModel.updateDocument(
                                            semester: '222',
                                            documentID: viewModel.trainingPoint?.documentId ?? "",
                                            key: "activate4",
                                            value: score,
                                            email: widget.email),
                                        scoreT: 2,
                                        score: viewModel.trainingPoint?.activate4 ?? 0,
                                        viewModel: viewModel,
                                      ),
                                    ),
                                    Consumer<TrainingPointViewModel>(
                                      builder: (context, viewModel, child) {
                                        final trainingPoint = viewModel.trainingPoint;
                                        final sumStudyPoints = (trainingPoint?.activate1 ?? 0) +
                                            (trainingPoint?.activate2 ?? 0) +
                                            (trainingPoint?.activate3 ?? 0) +
                                            (trainingPoint?.activate4 ?? 0); // Include study6 score
                                        return _SumGrade(
                                          description: "Cộng mục III:",
                                          sumTraningPoint: sumStudyPoints,
                                        );
                                      },
                                    ),
                                    const _TitleTrainingPoint(
                                      title:
                                          "IV. ĐÁNH GIÁ VỀ Ý THỨC CÔNG DÂN TRONG QUAN HỆ VỚI CỘNG ĐỒNG (25 điểm)",
                                    ),
                                    Selector<TrainingPointViewModel, TrainingPointModel?>(
                                      selector: (_, viewModel) => viewModel.trainingPoint,
                                      builder: (context, value, child) => _DescriptionTrainingPoint(
                                        email: widget.email,
                                        description:
                                            'Có ý thức chấp hành, tham gia tuyên truyền các chủ trương của Đảng, chính sách, pháp luật của Nhà nước:(4 điểm)',
                                        onScoreChanged: (score) => viewModel.updateDocument(
                                            semester: '222',
                                            documentID: viewModel.trainingPoint?.documentId ?? "",
                                            key: "relation1",
                                            value: score,
                                            email: widget.email),
                                        scoreT: 4,
                                        score: viewModel.trainingPoint?.relation1 ?? 0,
                                        viewModel: viewModel,
                                      ),
                                    ),
                                    Selector<TrainingPointViewModel, TrainingPointModel?>(
                                      selector: (_, viewModel) => viewModel.trainingPoint,
                                      builder: (context, value, child) => _DescriptionTrainingPoint(
                                        email: widget.email,
                                        description:
                                            'Có tham gia bảo hiểm y tế ( bắt buộc) theo Luật bảo hiểm y tế.(10 điểm)',
                                        onScoreChanged: (score) => viewModel.updateDocument(
                                            semester: '222',
                                            documentID: viewModel.trainingPoint?.documentId ?? "",
                                            key: "relation2",
                                            value: score,
                                            email: widget.email),
                                        scoreT: 10,
                                        score: viewModel.trainingPoint?.relation2 ?? 0,
                                        viewModel: viewModel,
                                      ),
                                    ),
                                    Selector<TrainingPointViewModel, TrainingPointModel?>(
                                      selector: (_, viewModel) => viewModel.trainingPoint,
                                      builder: (context, value, child) => _DescriptionTrainingPoint(
                                        email: widget.email,
                                        description:
                                            'Có ý thức chấp hành, tham gia tuyên truyền các quy định về đảm bảo an toàn giao thông và “văn hóa giao thông”.(5 điểm)',
                                        onScoreChanged: (score) => viewModel.updateDocument(
                                            semester: '222',
                                            documentID: viewModel.trainingPoint?.documentId ?? "",
                                            key: "relation3",
                                            value: score,
                                            email: widget.email),
                                        scoreT: 5,
                                        score: viewModel.trainingPoint?.relation3 ?? 0,
                                        viewModel: viewModel,
                                      ),
                                    ),
                                    Selector<TrainingPointViewModel, TrainingPointModel?>(
                                      selector: (_, viewModel) => viewModel.trainingPoint,
                                      builder: (context, value, child) => _DescriptionTrainingPoint(
                                        email: widget.email,
                                        description:
                                            'Có ý thức tham gia các hoạt động xã hội có thành tích được ghi nhận, biểu dương khen thưởng.(4 điểm)',
                                        onScoreChanged: (score) => viewModel.updateDocument(
                                            semester: '222',
                                            documentID: viewModel.trainingPoint?.documentId ?? "",
                                            key: "relation4",
                                            value: score,
                                            email: widget.email),
                                        scoreT: 4,
                                        score: viewModel.trainingPoint?.relation4 ?? 0,
                                        viewModel: viewModel,
                                      ),
                                    ),
                                    Selector<TrainingPointViewModel, TrainingPointModel?>(
                                      selector: (_, viewModel) => viewModel.trainingPoint,
                                      builder: (context, value, child) => _DescriptionTrainingPoint(
                                        email: widget.email,
                                        description:
                                            'Có tinh thần chia sẻ, giúp đỡ người gặp khó khăn, hoạn nạn.(2 điểm)',
                                        onScoreChanged: (score) => viewModel.updateDocument(
                                            semester: '222',
                                            documentID: viewModel.trainingPoint?.documentId ?? "",
                                            key: "relation5",
                                            value: score,
                                            email: widget.email),
                                        scoreT: 2,
                                        score: viewModel.trainingPoint?.relation5 ?? 0,
                                        viewModel: viewModel,
                                      ),
                                    ),
                                    Consumer<TrainingPointViewModel>(
                                      builder: (context, viewModel, child) {
                                        final trainingPoint = viewModel.trainingPoint;
                                        final sumStudyPoints = (trainingPoint?.relation1 ?? 0) +
                                            (trainingPoint?.relation2 ?? 0) +
                                            (trainingPoint?.relation3 ?? 0) +
                                            (trainingPoint?.relation4 ?? 0) +
                                            (trainingPoint?.relation5 ?? 0); // Include study6 score
                                        return _SumGrade(
                                          description: "Cộng mục VI:",
                                          sumTraningPoint: sumStudyPoints,
                                        );
                                      },
                                    ),
                                    const _TitleTrainingPoint(
                                      title:
                                          "V. ĐÁNH GIÁ VỀ Ý THỨC VÀ KẾT QUẢ KHI THAM GIA CÔNG TÁC CÁN BỘ LỚP, CÁC ĐOÀN THỂ, TỔ CHỨC TRONG NHÀ TRƯỜNG HOẶC SINH VIÊN ĐẠT ĐƯỢC THÀNH TÍCH TRONG HỌC TẬP, RÈN LUYỆN (10 điểm)",
                                    ),
                                    Selector<TrainingPointViewModel, TrainingPointModel?>(
                                      selector: (_, viewModel) => viewModel.trainingPoint,
                                      builder: (context, value, child) => _DescriptionTrainingPoint(
                                        email: widget.email,
                                        description:
                                            'Có ý thức, uy tín và hoàn thành tốt nhiệm vụ quản lý lớp, các tổ chức Đảng, Đoàn Thanh niên, Hội Sinh viên, tổ chức khác trong nhà trường.(3 điểm)',
                                        onScoreChanged: (score) => viewModel.updateDocument(
                                            semester: '222',
                                            documentID: viewModel.trainingPoint?.documentId ?? "",
                                            key: "monitor1",
                                            value: score,
                                            email: widget.email),
                                        scoreT: 3,
                                        score: viewModel.trainingPoint?.monitor1 ?? 0,
                                        viewModel: viewModel,
                                      ),
                                    ),
                                    Selector<TrainingPointViewModel, TrainingPointModel?>(
                                      selector: (_, viewModel) => viewModel.trainingPoint,
                                      builder: (context, value, child) => _DescriptionTrainingPoint(
                                        email: widget.email,
                                        description:
                                            'Có kỹ năng tổ chức, quản lý lớp, các tổ chức Đảng, Đoàn Thanh niên, Hội Sinh viên và các tổ chức khác trong nhà trường.(2 điểm)',
                                        onScoreChanged: (score) => viewModel.updateDocument(
                                            semester: '222',
                                            documentID: viewModel.trainingPoint?.documentId ?? "",
                                            key: "monitor2",
                                            value: score,
                                            email: widget.email),
                                        scoreT: 2,
                                        score: viewModel.trainingPoint?.monitor2 ?? 0,
                                        viewModel: viewModel,
                                      ),
                                    ),
                                    Selector<TrainingPointViewModel, TrainingPointModel?>(
                                      selector: (_, viewModel) => viewModel.trainingPoint,
                                      builder: (context, value, child) => _DescriptionTrainingPoint(
                                        email: widget.email,
                                        description:
                                            'Hỗ trợ tham gia tích cực vào các hoạt động chung của lớp, tập thể khoa, trường và Đại học Đà Nẵng.(3 điểm)',
                                        onScoreChanged: (score) => viewModel.updateDocument(
                                            semester: '222',
                                            documentID: viewModel.trainingPoint?.documentId ?? "",
                                            key: "monitor3",
                                            value: score,
                                            email: widget.email),
                                        scoreT: 3,
                                        score: viewModel.trainingPoint?.monitor3 ?? 0,
                                        viewModel: viewModel,
                                      ),
                                    ),
                                    Selector<TrainingPointViewModel, TrainingPointModel?>(
                                      selector: (_, viewModel) => viewModel.trainingPoint,
                                      builder: (context, value, child) => _DescriptionTrainingPoint(
                                        email: widget.email,
                                        description:
                                            'Đạt thành tích trong học tập, rèn luyện (được tặng bằng khen, giấy khen, chứng nhận, thư khen của các cấp).(2 điểm)',
                                        onScoreChanged: (score) => viewModel.updateDocument(
                                            semester: '222',
                                            documentID: viewModel.trainingPoint?.documentId ?? "",
                                            key: "monitor4",
                                            value: score,
                                            email: widget.email),
                                        scoreT: 2,
                                        score: viewModel.trainingPoint?.monitor4 ?? 0,
                                        viewModel: viewModel,
                                      ),
                                    ),
                                    Consumer<TrainingPointViewModel>(
                                      builder: (context, viewModel, child) {
                                        final trainingPoint = viewModel.trainingPoint;
                                        final sumStudyPoints = (trainingPoint?.monitor1 ?? 0) +
                                            (trainingPoint?.monitor2 ?? 0) +
                                            (trainingPoint?.monitor3 ?? 0) +
                                            (trainingPoint?.monitor4 ?? 0); // Include study6 score
                                        return _SumGrade(
                                          description: "Cộng mục V:",
                                          sumTraningPoint: sumStudyPoints,
                                        );
                                      },
                                    ),
                                    Consumer<TrainingPointViewModel>(
                                      builder: (context, viewModel, child) {
                                        final trainingPoint = viewModel.trainingPoint;
                                        final sumStudyPoints =
                                            (trainingPoint?.trainingPoint1 ?? 0) +
                                                (trainingPoint?.trainingPoint2 ?? 0) +
                                                (trainingPoint?.trainingPoint3 ?? 0) +
                                                (trainingPoint?.trainingPoint4 ?? 0) +
                                                (trainingPoint?.trainingPoint5 ??
                                                    0); // Include study6 score
                                        return _SumGrade(
                                          description: "Tổng điểm:",
                                          sumTraningPoint: sumStudyPoints,
                                        );
                                      },
                                    ),
                                    Consumer<TrainingPointViewModel>(
                                      builder: (context, viewModel, child) {
                                        final trainingPoint = viewModel.trainingPoint;
                                        final sumStudyPoints =
                                            (trainingPoint?.trainingPoint1 ?? 0) +
                                                (trainingPoint?.trainingPoint2 ?? 0) +
                                                (trainingPoint?.trainingPoint3 ?? 0) +
                                                (trainingPoint?.trainingPoint4 ?? 0) +
                                                (trainingPoint?.trainingPoint5 ??
                                                    0); // Include study6 score
                                        return _Rank(
                                          description: "Xếp loại:",
                                          rank: sumStudyPoints,
                                        );
                                      },
                                    ),
                                    !widget.absorbing
                                        ? Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: UIOutlineButton(
                                              title: 'Nộp điểm',
                                              onPressed: () {
                                                Utils.showPopup(context,
                                                    icon: AppAssets.icCheck,
                                                    title: "Nộp điểm thành công",
                                                    message:
                                                        "Bạn có thể cập nhật cho đến khi thời gian chấm kết thúc");
                                                viewModel.updateDocument(
                                                    semester: '222',
                                                    documentID:
                                                        viewModel.trainingPoint?.documentId ?? "",
                                                    key: "history",
                                                    value: true,
                                                    email: widget.email);
                                              },
                                            ),
                                          )
                                        : const SizedBox.shrink()
                                  ],
                                ),
                              ),
                            ),
                          )
                        : const UIEmptyPngScreen(
                            iconAsset: AppAssets.icTrainingPoint,
                            title: "Thời gian chấm điểm rèn luyện chưa tới",
                            message: "Xin quay lại sau");
                  })),
    );
  }
}

class _DescriptionTrainingPoint extends StatelessWidget {
  final String description;
  final void Function(int) onScoreChanged;
  final int scoreT;
  final int score;
  final TrainingPointViewModel viewModel;
  final String email;

  const _DescriptionTrainingPoint({
    required this.description,
    required this.onScoreChanged,
    required this.scoreT,
    required this.score,
    required this.viewModel,
    required this.email,
  });

  void changeScore() {
    int newScore = score == scoreT ? score - scoreT : score + scoreT;
    onScoreChanged(newScore);

    viewModel.getTrainingPoint(email, "222").then((_) {
      final trainingPoint = viewModel.trainingPoint;
      final sumStudyPoints1 = (trainingPoint?.study1 ?? 0) +
          (trainingPoint?.study2 ?? 0) +
          (trainingPoint?.study3 ?? 0) +
          (trainingPoint?.study4 ?? 0) +
          (trainingPoint?.study5 ?? 0) +
          (trainingPoint?.study6 ?? 0);

      final sumStudyPoints2 = (trainingPoint?.rules1 ?? 0) +
          (trainingPoint?.rules2 ?? 0) +
          (trainingPoint?.rules3 ?? 0) +
          (trainingPoint?.rules4 ?? 0);

      final sumStudyPoints3 = (trainingPoint?.activate1 ?? 0) +
          (trainingPoint?.activate2 ?? 0) +
          (trainingPoint?.activate3 ?? 0) +
          (trainingPoint?.activate4 ?? 0);

      final sumStudyPoints4 = (trainingPoint?.relation1 ?? 0) +
          (trainingPoint?.relation2 ?? 0) +
          (trainingPoint?.relation3 ?? 0) +
          (trainingPoint?.relation4 ?? 0) +
          (trainingPoint?.relation5 ?? 0);

      final sumStudyPoints5 = (trainingPoint?.monitor1 ?? 0) +
          (trainingPoint?.monitor2 ?? 0) +
          (trainingPoint?.monitor3 ?? 0) +
          (trainingPoint?.monitor4 ?? 0);

      final sumStudyPoints6 = (trainingPoint?.study1 ?? 0) +
          (trainingPoint?.study2 ?? 0) +
          (trainingPoint?.study3 ?? 0) +
          (trainingPoint?.study4 ?? 0) +
          (trainingPoint?.study5 ?? 0) +
          (trainingPoint?.study6 ?? 0) +
          (trainingPoint?.rules1 ?? 0) +
          (trainingPoint?.rules2 ?? 0) +
          (trainingPoint?.rules3 ?? 0) +
          (trainingPoint?.rules4 ?? 0) +
          (trainingPoint?.activate1 ?? 0) +
          (trainingPoint?.activate2 ?? 0) +
          (trainingPoint?.activate3 ?? 0) +
          (trainingPoint?.activate4 ?? 0) +
          (trainingPoint?.relation1 ?? 0) +
          (trainingPoint?.relation2 ?? 0) +
          (trainingPoint?.relation3 ?? 0) +
          (trainingPoint?.relation4 ?? 0) +
          (trainingPoint?.relation5 ?? 0) +
          (trainingPoint?.monitor1 ?? 0) +
          (trainingPoint?.monitor2 ?? 0) +
          (trainingPoint?.monitor3 ?? 0) +
          (trainingPoint?.monitor4 ?? 0);
      return Future.wait([
        viewModel.updateDocument(
            semester: '222',
            documentID: viewModel.trainingPoint?.documentId ?? "",
            key: "trainingPoint1",
            value: sumStudyPoints1,
            email: email),
        viewModel.updateDocument(
            semester: '222',
            documentID: viewModel.trainingPoint?.documentId ?? "",
            key: "trainingPoint2",
            value: sumStudyPoints2,
            email: email),
        viewModel.updateDocument(
            semester: '222',
            documentID: viewModel.trainingPoint?.documentId ?? "",
            key: "trainingPoint3",
            value: sumStudyPoints3,
            email: email),
        viewModel.updateDocument(
            semester: '222',
            documentID: viewModel.trainingPoint?.documentId ?? "",
            key: "trainingPoint4",
            value: sumStudyPoints4,
            email: email),
        viewModel.updateDocument(
            semester: '222',
            documentID: viewModel.trainingPoint?.documentId ?? "",
            key: "trainingPoint5",
            value: sumStudyPoints5,
            email: email),
        viewModel.updateDocument(
            semester: '222',
            documentID: viewModel.trainingPoint?.documentId ?? "",
            key: "trainingPoint",
            value: sumStudyPoints6,
            email: email),
        viewModel.updateDocument(
            semester: '222',
            documentID: viewModel.trainingPoint?.documentId ?? "",
            key: "rank",
            value: sumStudyPoints6 > 90
                ? "Xuất sắc"
                : sumStudyPoints6 > 80
                    ? "Tốt"
                    : sumStudyPoints6 > 65
                        ? "Khá"
                        : sumStudyPoints6 > 50
                            ? "Trung bình"
                            : sumStudyPoints6 > 35
                                ? "Yếu"
                                : "Kém",
            email: email),
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: changeScore,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: score == 0 ? AppColors.white : AppColors.enableBlue,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 5,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: Text(
              '$description\nĐiểm: $score',
              style: TextStyle(
                fontSize: DimensManager.dimens.setSp(16),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TitleTrainingPoint extends StatelessWidget {
  const _TitleTrainingPoint({
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.blue,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: UIText(
            color: Colors.white,
            title,
            style: TextStyle(fontSize: DimensManager.dimens.setSp(17), fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }
}

class _SumGrade extends StatelessWidget {
  const _SumGrade({
    required this.description,
    required this.sumTraningPoint,
  });
  final String description;
  final int sumTraningPoint;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: UIText(
              description,
              style:
                  TextStyle(fontSize: DimensManager.dimens.setSp(16), fontWeight: FontWeight.w800),
            ),
          ),
          UIText(
            "$sumTraningPoint",
            fontWeight: FontWeight.w800,
          ),
        ],
      ),
    );
  }
}

class _Rank extends StatelessWidget {
  const _Rank({
    required this.description,
    required this.rank,
  });
  final String description;
  final int rank;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: UIText(
              description,
              style:
                  TextStyle(fontSize: DimensManager.dimens.setSp(16), fontWeight: FontWeight.w800),
            ),
          ),
          UIText(
            rank > 90
                ? "Xuất sắc"
                : rank > 80
                    ? "Tốt"
                    : rank > 65
                        ? "Khá"
                        : rank > 50
                            ? "Trung bình"
                            : rank > 35
                                ? "Yếu"
                                : "Kém",
            fontWeight: FontWeight.w800,
          ),
        ],
      ),
    );
  }
}

Widget _buildLoadingIndicator() {
  return const Center(
    child: CircularProgressIndicator(), // Thay thế bằng widget chỉ báo tải của bạn
  );
}
