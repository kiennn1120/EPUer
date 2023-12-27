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

class TrainingPointsGvcnDetailScreen extends StatefulWidget {
  final String email;
  final bool absorbing;
  final String semester;

  const TrainingPointsGvcnDetailScreen(
      {Key? key, required this.email, required this.absorbing, required this.semester})
      : super(key: key);

  @override
  _TrainingPointsGvcnDetailScreenState createState() => _TrainingPointsGvcnDetailScreenState();
}

class _TrainingPointsGvcnDetailScreenState extends State<TrainingPointsGvcnDetailScreen> {
  late TrainingPointViewModel viewModel;
  late String email;
  bool isLoading = true;
  @override
  void initState() {
    viewModel = TrainingPointViewModel(repository: TrainingPointRepository())..onInitView(context);
    super.initState();

    viewModel.getTrainingPoint(widget.email, widget.semester);
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
          appBar:
              appBar(context, widget.absorbing ? 'Lịch sử điểm rèn luyện' : 'Duyệt điểm rèn luyện'),
          body: isLoading
              ? _buildLoadingIndicator()
              : Selector<TrainingPointViewModel, OpenTrainingPointModel?>(
                  selector: (_, viewModel) => viewModel.openTrainingPoint,
                  builder: (context, value, child) {
                    final isOpen = value?.open ?? false;
                    if (isOpen) {
                      return SingleChildScrollView(
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
                                    studentScore: viewModel.trainingPoint?.study1 ?? 0,
                                    teacherScore: viewModel.trainingPoint?.teacherStudy1 ?? 0,
                                    email: widget.email,
                                    description:
                                        'Có đi học chuyên cần, đúng giờ, nghiêm túc trong giờ học; đủ điều kiện dự thi tất cả các học phần. \n(4 điểm)',
                                    onScoreChanged: (score) => viewModel.updateDocument(
                                        semester: '222',
                                        documentID: viewModel.trainingPoint?.documentId ?? "",
                                        key: "teacherStudy1",
                                        value: score,
                                        email: widget.email),
                                    scoreT: 4,
                                    viewModel: viewModel,
                                  ),
                                ),
                                Selector<TrainingPointViewModel, TrainingPointModel?>(
                                  selector: (_, viewModel) => viewModel.trainingPoint,
                                  builder: (context, value, child) => _DescriptionTrainingPoint(
                                    email: widget.email,
                                    description:
                                        'Có ý thức tham gia các câu lạc bộ học thuật, các hoạt động học thuật, hoạt động ngoại khóa.\n	(2 điểm)',
                                    onScoreChanged: (score) => viewModel.updateDocument(
                                        semester: '222',
                                        documentID: viewModel.trainingPoint?.documentId ?? "",
                                        key: "teacherStudy2",
                                        value: score,
                                        email: widget.email),
                                    scoreT: 2,
                                    studentScore: viewModel.trainingPoint?.study2 ?? 0,
                                    teacherScore: viewModel.trainingPoint?.teacherStudy2 ?? 0,
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
                                        key: "teacherStudy3",
                                        value: score,
                                        email: widget.email),
                                    scoreT: 2,
                                    studentScore: viewModel.trainingPoint?.study3 ?? 0,
                                    teacherScore: viewModel.trainingPoint?.teacherStudy3 ?? 0,
                                    viewModel: viewModel,
                                  ),
                                ),
                                Selector<TrainingPointViewModel, TrainingPointModel?>(
                                  selector: (_, viewModel) => viewModel.trainingPoint,
                                  builder: (context, value, child) => _DescriptionTrainingPoint(
                                    email: widget.email,
                                    description:
                                        'Không vi phạm quy chế thi và kiểm tra                              \n(6 điểm)',
                                    onScoreChanged: (score) => viewModel.updateDocument(
                                        semester: '222',
                                        documentID: viewModel.trainingPoint?.documentId ?? "",
                                        key: "teacherStudy4",
                                        value: score,
                                        email: widget.email),
                                    scoreT: 6,
                                    studentScore: viewModel.trainingPoint?.study4 ?? 0,
                                    teacherScore: viewModel.trainingPoint?.teacherStudy4 ?? 0,
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
                                        key: "teacherStudy5",
                                        value: score,
                                        email: widget.email),
                                    scoreT: 2,
                                    studentScore: viewModel.trainingPoint?.study5 ?? 0,
                                    teacherScore: viewModel.trainingPoint?.teacherStudy5 ?? 0,
                                    viewModel: viewModel,
                                  ),
                                ),
                                Selector<TrainingPointViewModel, TrainingPointModel?>(
                                  selector: (_, viewModel) => viewModel.trainingPoint,
                                  builder: (context, value, child) => Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Radio<int>(
                                            value: 4,
                                            groupValue: viewModel.trainingPoint?.study6,
                                            onChanged: null,
                                          ),
                                          const SizedBox(width: 8),
                                          const Text('ĐTBCHK từ 3,2 đến 4,0 (4 điểm)  '),
                                          Radio<int>(
                                            value: 4,
                                            groupValue: viewModel.trainingPoint?.teacherStudy6,
                                            onChanged: (score) {
                                              viewModel.updateDocument(
                                                  semester: '222',
                                                  documentID:
                                                      viewModel.trainingPoint?.documentId ?? "",
                                                  key: "teacherStudy6",
                                                  value: score ?? 0,
                                                  email: widget.email);
                                            },
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Radio<int>(
                                            value: 2,
                                            groupValue: viewModel.trainingPoint?.study6,
                                            onChanged: null,
                                          ),
                                          const SizedBox(width: 8),
                                          const Text('ĐTBCHK từ 2,0 đến 3,19 (2 điểm)'),
                                          Radio<int>(
                                            value: 2,
                                            groupValue: viewModel.trainingPoint?.teacherStudy6,
                                            onChanged: (score) {
                                              viewModel.updateDocument(
                                                  semester: '222',
                                                  documentID:
                                                      viewModel.trainingPoint?.documentId ?? "",
                                                  key: "teacherStudy6",
                                                  value: score ?? 0,
                                                  email: widget.email);
                                            },
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Radio<int>(
                                            value: 0,
                                            groupValue: viewModel.trainingPoint?.study6,
                                            onChanged: null,
                                          ),
                                          const SizedBox(width: 8),
                                          const Text('ĐTBCHK dưới 2,0 (0 điểm)            '),
                                          Radio<int>(
                                            value: 0,
                                            groupValue: viewModel.trainingPoint?.teacherStudy6,
                                            onChanged: (score) {
                                              viewModel.updateDocument(
                                                  semester: '222',
                                                  documentID:
                                                      viewModel.trainingPoint?.documentId ?? "",
                                                  key: "teacherStudy6",
                                                  value: score ?? 0,
                                                  email: widget.email);
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Consumer<TrainingPointViewModel>(
                                  builder: (context, viewModel, child) {
                                    final trainingPoint = viewModel.trainingPoint;
                                    final sumStudyPoints = (trainingPoint?.teacherStudy1 ?? 0) +
                                        (trainingPoint?.teacherStudy2 ?? 0) +
                                        (trainingPoint?.teacherStudy3 ?? 0) +
                                        (trainingPoint?.teacherStudy4 ?? 0) +
                                        (trainingPoint?.teacherStudy5 ?? 0) +
                                        (trainingPoint?.teacherStudy6 ?? 0); // Include study6 score
                                    return _SumGrade(
                                      description: "Cộng mục I:",
                                      studentGrade: trainingPoint?.trainingPoint1 ?? 0,
                                      teacherGrade: sumStudyPoints,
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
                                        key: "teacherRules1",
                                        value: score,
                                        email: widget.email),
                                    scoreT: 6,
                                    studentScore: viewModel.trainingPoint?.rules1 ?? 0,
                                    teacherScore: viewModel.trainingPoint?.teacherRules1 ?? 0,
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
                                        key: "teacherRules2",
                                        value: score,
                                        email: widget.email),
                                    scoreT: 4,
                                    studentScore: viewModel.trainingPoint?.rules2 ?? 0,
                                    teacherScore: viewModel.trainingPoint?.teacherRules2 ?? 0,
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
                                        key: "teacherRules3",
                                        value: score,
                                        email: widget.email),
                                    scoreT: 10,
                                    studentScore: viewModel.trainingPoint?.rules3 ?? 0,
                                    teacherScore: viewModel.trainingPoint?.teacherRules3 ?? 0,
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
                                        key: "teacherRules4",
                                        value: score,
                                        email: widget.email),
                                    scoreT: 5,
                                    studentScore: viewModel.trainingPoint?.rules4 ?? 0,
                                    teacherScore: viewModel.trainingPoint?.teacherRules4 ?? 0,
                                    viewModel: viewModel,
                                  ),
                                ),
                                Consumer<TrainingPointViewModel>(
                                  builder: (context, viewModel, child) {
                                    final trainingPoint = viewModel.trainingPoint;
                                    final sumStudyPoints = (trainingPoint?.teacherRules1 ?? 0) +
                                        (trainingPoint?.teacherRules2 ?? 0) +
                                        (trainingPoint?.teacherRules3 ?? 0) +
                                        (trainingPoint?.teacherRules4 ?? 0); // Include study6 score
                                    return _SumGrade(
                                      description: "Cộng mục II:",
                                      teacherGrade: sumStudyPoints,
                                      studentGrade: trainingPoint?.trainingPoint2 ?? 0,
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
                                        key: "teacherActivate1",
                                        value: score,
                                        email: widget.email),
                                    scoreT: 10,
                                    studentScore: viewModel.trainingPoint?.activate1 ?? 0,
                                    teacherScore: viewModel.trainingPoint?.teacherActivate1 ?? 0,
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
                                        key: "teacherActivate2",
                                        value: score,
                                        email: widget.email),
                                    scoreT: 6,
                                    studentScore: viewModel.trainingPoint?.activate2 ?? 0,
                                    teacherScore: viewModel.trainingPoint?.teacherActivate2 ?? 0,
                                    viewModel: viewModel,
                                  ),
                                ),
                                Selector<TrainingPointViewModel, TrainingPointModel?>(
                                  selector: (_, viewModel) => viewModel.trainingPoint,
                                  builder: (context, value, child) => _DescriptionTrainingPoint(
                                    email: widget.email,
                                    description:
                                        'Có ý thức tham gia các hoạt động công ích, tình nguyện, công tác xã hội trong nhà trường.	\n(2 điểm)',
                                    onScoreChanged: (score) => viewModel.updateDocument(
                                        semester: '222',
                                        documentID: viewModel.trainingPoint?.documentId ?? "",
                                        key: "teacherActivate3",
                                        value: score,
                                        email: widget.email),
                                    scoreT: 2,
                                    studentScore: viewModel.trainingPoint?.activate3 ?? 0,
                                    teacherScore: viewModel.trainingPoint?.teacherActivate3 ?? 0,
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
                                        key: "teacherActivate4",
                                        value: score,
                                        email: widget.email),
                                    scoreT: 2,
                                    studentScore: viewModel.trainingPoint?.activate4 ?? 0,
                                    teacherScore: viewModel.trainingPoint?.teacherActivate4 ?? 0,
                                    viewModel: viewModel,
                                  ),
                                ),
                                Consumer<TrainingPointViewModel>(
                                  builder: (context, viewModel, child) {
                                    final trainingPoint = viewModel.trainingPoint;
                                    final sumStudyPoints = (trainingPoint?.teacherActivate1 ?? 0) +
                                        (trainingPoint?.teacherActivate2 ?? 0) +
                                        (trainingPoint?.teacherActivate3 ?? 0) +
                                        (trainingPoint?.teacherActivate4 ??
                                            0); // Include study6 score
                                    return _SumGrade(
                                      description: "Cộng mục III:",
                                      teacherGrade: sumStudyPoints,
                                      studentGrade: trainingPoint?.trainingPoint3 ?? 0,
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
                                        key: "teacherRelation1",
                                        value: score,
                                        email: widget.email),
                                    scoreT: 4,
                                    studentScore: viewModel.trainingPoint?.relation1 ?? 0,
                                    teacherScore: viewModel.trainingPoint?.teacherRelation1 ?? 0,
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
                                        key: "teacherRelation2",
                                        value: score,
                                        email: widget.email),
                                    scoreT: 10,
                                    studentScore: viewModel.trainingPoint?.relation2 ?? 0,
                                    teacherScore: viewModel.trainingPoint?.teacherRelation2 ?? 0,
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
                                        key: "teacherRelation3",
                                        value: score,
                                        email: widget.email),
                                    scoreT: 5,
                                    studentScore: viewModel.trainingPoint?.relation3 ?? 0,
                                    teacherScore: viewModel.trainingPoint?.teacherRelation3 ?? 0,
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
                                        key: "teacherRelation4",
                                        value: score,
                                        email: widget.email),
                                    scoreT: 4,
                                    studentScore: viewModel.trainingPoint?.relation4 ?? 0,
                                    teacherScore: viewModel.trainingPoint?.teacherRelation4 ?? 0,
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
                                        key: "teacherRelation5",
                                        value: score,
                                        email: widget.email),
                                    scoreT: 2,
                                    studentScore: viewModel.trainingPoint?.relation5 ?? 0,
                                    teacherScore: viewModel.trainingPoint?.teacherRelation5 ?? 0,
                                    viewModel: viewModel,
                                  ),
                                ),
                                Consumer<TrainingPointViewModel>(
                                  builder: (context, viewModel, child) {
                                    final trainingPoint = viewModel.trainingPoint;
                                    final sumStudyPoints = (trainingPoint?.teacherRelation1 ?? 0) +
                                        (trainingPoint?.teacherRelation2 ?? 0) +
                                        (trainingPoint?.teacherRelation3 ?? 0) +
                                        (trainingPoint?.teacherRelation4 ?? 0) +
                                        (trainingPoint?.teacherRelation5 ?? 0);
                                    return _SumGrade(
                                      description: "Cộng mục VI:",
                                      teacherGrade: sumStudyPoints,
                                      studentGrade: trainingPoint?.trainingPoint4 ?? 0,
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
                                        key: "teacherMonitor1",
                                        value: score,
                                        email: widget.email),
                                    scoreT: 3,
                                    studentScore: viewModel.trainingPoint?.monitor1 ?? 0,
                                    teacherScore: viewModel.trainingPoint?.teacherMonitor1 ?? 0,
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
                                        key: "teacherMonitor2",
                                        value: score,
                                        email: widget.email),
                                    scoreT: 2,
                                    studentScore: viewModel.trainingPoint?.monitor2 ?? 0,
                                    teacherScore: viewModel.trainingPoint?.teacherMonitor2 ?? 0,
                                    viewModel: viewModel,
                                  ),
                                ),
                                Selector<TrainingPointViewModel, TrainingPointModel?>(
                                  selector: (_, viewModel) => viewModel.trainingPoint,
                                  builder: (context, value, child) => _DescriptionTrainingPoint(
                                    email: widget.email,
                                    description:
                                        'Hỗ trợ tham gia tích cực vào các hoạt động chung của lớp, tập thể khoa, trường và Đại học Đà Nẵng.\n(3 điểm)',
                                    onScoreChanged: (score) => viewModel.updateDocument(
                                        semester: '222',
                                        documentID: viewModel.trainingPoint?.documentId ?? "",
                                        key: "teacherMonitor3",
                                        value: score,
                                        email: widget.email),
                                    scoreT: 3,
                                    studentScore: viewModel.trainingPoint?.monitor3 ?? 0,
                                    teacherScore: viewModel.trainingPoint?.teacherMonitor3 ?? 0,
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
                                        key: "teacherMonitor4",
                                        value: score,
                                        email: widget.email),
                                    scoreT: 2,
                                    studentScore: viewModel.trainingPoint?.monitor4 ?? 0,
                                    teacherScore: viewModel.trainingPoint?.teacherMonitor4 ?? 0,
                                    viewModel: viewModel,
                                  ),
                                ),
                                Consumer<TrainingPointViewModel>(
                                  builder: (context, viewModel, child) {
                                    final trainingPoint = viewModel.trainingPoint;
                                    final sumStudyPoints = (trainingPoint?.teacherMonitor1 ?? 0) +
                                        (trainingPoint?.teacherMonitor2 ?? 0) +
                                        (trainingPoint?.teacherMonitor3 ?? 0) +
                                        (trainingPoint?.teacherMonitor4 ?? 0);
                                    return _SumGrade(
                                      description: "Cộng mục V:",
                                      teacherGrade: sumStudyPoints,
                                      studentGrade: trainingPoint?.trainingPoint5 ?? 0,
                                    );
                                  },
                                ),
                                Consumer<TrainingPointViewModel>(
                                  builder: (context, viewModel, child) {
                                    final trainingPoint = viewModel.trainingPoint;
                                    final sumStudyPoints =
                                        (trainingPoint?.teacherTrainingPoint1 ?? 0) +
                                            (trainingPoint?.teacherTrainingPoint2 ?? 0) +
                                            (trainingPoint?.teacherTrainingPoint3 ?? 0) +
                                            (trainingPoint?.teacherTrainingPoint4 ?? 0) +
                                            (trainingPoint?.teacherTrainingPoint5 ?? 0);
                                    return _SumGrade(
                                      description: "Tổng điểm:",
                                      teacherGrade: sumStudyPoints,
                                      studentGrade: trainingPoint?.trainingPoint ?? 0,
                                    );
                                  },
                                ),
                                Consumer<TrainingPointViewModel>(
                                  builder: (context, viewModel, child) {
                                    final trainingPoint = viewModel.trainingPoint;
                                    final sumStudyPoints =
                                        (trainingPoint?.teacherTrainingPoint1 ?? 0) +
                                            (trainingPoint?.teacherTrainingPoint2 ?? 0) +
                                            (trainingPoint?.teacherTrainingPoint3 ?? 0) +
                                            (trainingPoint?.teacherTrainingPoint4 ?? 0) +
                                            (trainingPoint?.teacherTrainingPoint5 ?? 0);
                                    return _Rank(
                                      teacherRank: sumStudyPoints,
                                      studentRank: trainingPoint?.trainingPoint ?? 0,
                                    );
                                  },
                                ),
                                !widget.absorbing
                                    ? Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: UIOutlineButton(
                                          title: 'Duyệt điểm',
                                          onPressed: () {
                                            Utils.showPopup(context,
                                                icon: AppAssets.icCheck,
                                                title: "Duyệt điểm thành công",
                                                message:
                                                    "Bạn có thể cập nhật cho đến khi thời gian chấm kết thúc");
                                            viewModel.updateDocument(
                                                semester: '222',
                                                documentID:
                                                    viewModel.trainingPoint?.documentId ?? "",
                                                key: "status",
                                                value: true,
                                                email: widget.email);
                                            addNotification(email: widget.email);
                                          },
                                        ),
                                      )
                                    : const SizedBox.shrink()
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const UIEmptyPngScreen(
                          iconAsset: AppAssets.icTrainingPoint,
                          title: "Thời gian chấm điểm rèn luyện chưa tới",
                          message: "Xin quay lại sau");
                    }
                  })),
    );
  }
}

class _DescriptionTrainingPoint extends StatefulWidget {
  final String description;
  final void Function(int) onScoreChanged;
  final int scoreT;
  final int studentScore;
  final int teacherScore;
  final TrainingPointViewModel viewModel;
  final String email;

  const _DescriptionTrainingPoint({
    required this.description,
    required this.onScoreChanged,
    required this.scoreT,
    required this.studentScore,
    required this.teacherScore,
    required this.viewModel,
    required this.email,
  });

  @override
  _DescriptionTrainingPointState createState() => _DescriptionTrainingPointState();
}

class _DescriptionTrainingPointState extends State<_DescriptionTrainingPoint> {
  bool isChecked = false;
  @override
  void initState() {
    super.initState();
    isChecked = (widget.teacherScore == widget.scoreT);
  }

  void toggleCheckbox() {
    setState(() {
      isChecked = !isChecked;
      if (isChecked) {
        widget.onScoreChanged(widget.scoreT + widget.teacherScore);
      } else {
        widget.onScoreChanged(widget.scoreT - widget.teacherScore);
      }

      widget.viewModel.getTrainingPoint(widget.email, "222").then((_) {
        final trainingPoint = widget.viewModel.trainingPoint;
        final sumStudyPoints1 = (trainingPoint?.teacherStudy1 ?? 0) +
            (trainingPoint?.teacherStudy2 ?? 0) +
            (trainingPoint?.teacherStudy3 ?? 0) +
            (trainingPoint?.teacherStudy4 ?? 0) +
            (trainingPoint?.teacherStudy5 ?? 0) +
            (trainingPoint?.teacherStudy6 ?? 0);

        final sumStudyPoints2 = (trainingPoint?.teacherRules1 ?? 0) +
            (trainingPoint?.teacherRules2 ?? 0) +
            (trainingPoint?.teacherRules3 ?? 0) +
            (trainingPoint?.teacherRules4 ?? 0);

        final sumStudyPoints3 = (trainingPoint?.teacherActivate1 ?? 0) +
            (trainingPoint?.teacherActivate2 ?? 0) +
            (trainingPoint?.teacherActivate3 ?? 0) +
            (trainingPoint?.teacherActivate4 ?? 0);

        final sumStudyPoints4 = (trainingPoint?.teacherRelation1 ?? 0) +
            (trainingPoint?.teacherRelation2 ?? 0) +
            (trainingPoint?.teacherRelation3 ?? 0) +
            (trainingPoint?.teacherRelation4 ?? 0) +
            (trainingPoint?.teacherRelation5 ?? 0);

        final sumStudyPoints5 = (trainingPoint?.teacherMonitor1 ?? 0) +
            (trainingPoint?.teacherMonitor2 ?? 0) +
            (trainingPoint?.teacherMonitor3 ?? 0) +
            (trainingPoint?.teacherMonitor4 ?? 0);

        final sumStudyPoints6 = (trainingPoint?.teacherStudy1 ?? 0) +
            (trainingPoint?.teacherStudy2 ?? 0) +
            (trainingPoint?.teacherStudy3 ?? 0) +
            (trainingPoint?.teacherStudy4 ?? 0) +
            (trainingPoint?.teacherStudy5 ?? 0) +
            (trainingPoint?.teacherStudy6 ?? 0) +
            (trainingPoint?.teacherRules1 ?? 0) +
            (trainingPoint?.teacherRules2 ?? 0) +
            (trainingPoint?.teacherRules3 ?? 0) +
            (trainingPoint?.teacherRules4 ?? 0) +
            (trainingPoint?.teacherActivate1 ?? 0) +
            (trainingPoint?.teacherActivate2 ?? 0) +
            (trainingPoint?.teacherActivate3 ?? 0) +
            (trainingPoint?.teacherActivate4 ?? 0) +
            (trainingPoint?.teacherRelation1 ?? 0) +
            (trainingPoint?.teacherRelation2 ?? 0) +
            (trainingPoint?.teacherRelation3 ?? 0) +
            (trainingPoint?.teacherRelation4 ?? 0) +
            (trainingPoint?.teacherRelation5 ?? 0) +
            (trainingPoint?.teacherMonitor1 ?? 0) +
            (trainingPoint?.teacherMonitor2 ?? 0) +
            (trainingPoint?.teacherMonitor3 ?? 0) +
            (trainingPoint?.teacherMonitor4 ?? 0);
        return Future.wait([
          widget.viewModel.updateDocument(
              semester: '222',
              documentID: widget.viewModel.trainingPoint?.documentId ?? "",
              key: "teacherTrainingPoint1",
              value: sumStudyPoints1,
              email: widget.email),
          widget.viewModel.updateDocument(
              semester: '222',
              documentID: widget.viewModel.trainingPoint?.documentId ?? "",
              key: "teacherTrainingPoint2",
              value: sumStudyPoints2,
              email: widget.email),
          widget.viewModel.updateDocument(
              semester: '222',
              documentID: widget.viewModel.trainingPoint?.documentId ?? "",
              key: "teacherTrainingPoint3",
              value: sumStudyPoints3,
              email: widget.email),
          widget.viewModel.updateDocument(
              semester: '222',
              documentID: widget.viewModel.trainingPoint?.documentId ?? "",
              key: "teacherTrainingPoint4",
              value: sumStudyPoints4,
              email: widget.email),
          widget.viewModel.updateDocument(
              semester: '222',
              documentID: widget.viewModel.trainingPoint?.documentId ?? "",
              key: "teacherTrainingPoint5",
              value: sumStudyPoints5,
              email: widget.email),
          widget.viewModel.updateDocument(
              semester: '222',
              documentID: widget.viewModel.trainingPoint?.documentId ?? "",
              key: "teacherTrainingPoint",
              value: sumStudyPoints6,
              email: widget.email),
          widget.viewModel.updateDocument(
              semester: '222',
              documentID: widget.viewModel.trainingPoint?.documentId ?? "",
              key: "teacherRank",
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
              email: widget.email),
        ]);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: toggleCheckbox,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: widget.studentScore == 0 ? AppColors.white : AppColors.enableBlue,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 5,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${widget.description}\nSinh Viên: ${widget.studentScore}\nGiáo viên: ${widget.teacherScore}',
                  style: TextStyle(
                    fontSize: DimensManager.dimens.setSp(16),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Checkbox(
                value: isChecked,
                onChanged: (_) {
                  toggleCheckbox();
                },
              ),
            ),
          ],
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
    required this.studentGrade,
    required this.teacherGrade,
  });

  final String description;
  final int studentGrade;
  final int teacherGrade;

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
              style: TextStyle(
                fontSize: DimensManager.dimens.setSp(16),
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Row(
            children: [
              UIText(
                "Sinh Viên: $studentGrade",
                fontWeight: FontWeight.w800,
              ),
              const SizedBox(
                width: 10,
              ),
              UIText(
                "Giáo Viên: $teacherGrade",
                fontWeight: FontWeight.w800,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Rank extends StatelessWidget {
  const _Rank({
    required this.studentRank,
    required this.teacherRank,
  });
  final int studentRank;
  final int teacherRank;

  String getStudentRank(int teacherRank) {
    if (teacherRank > 90) {
      return "Xuất sắc";
    } else if (teacherRank > 80) {
      return "Tốt";
    } else if (teacherRank > 65) {
      return "Khá";
    } else if (teacherRank > 50) {
      return "Trung bình";
    } else if (teacherRank > 35) {
      return "Yếu";
    } else {
      return "Kém";
    }
  }

  @override
  Widget build(BuildContext context) {
    final student = getStudentRank(studentRank);
    final teacher = getStudentRank(teacherRank);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: UIText(
              "Xếp hạng:",
              style:
                  TextStyle(fontSize: DimensManager.dimens.setSp(16), fontWeight: FontWeight.w800),
            ),
          ),
          Row(
            children: [
              UIText(
                student,
                fontWeight: FontWeight.w800,
              ),
              const SizedBox(
                width: 50,
              ),
              UIText(
                teacher,
                fontWeight: FontWeight.w800,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _buildLoadingIndicator() {
  return const Center(
    child: CircularProgressIndicator(),
  );
}
