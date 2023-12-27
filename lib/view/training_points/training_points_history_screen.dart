import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/training_point_model.dart';
import '../../repository/training_point_repository.dart';
import '../../res/constant/app_assets.dart';
import '../../utils/dimens/dimens_manager.dart';
import '../../view/training_points/widget/training_point_history_card.dart';
import '../../view/widgets/appbar.dart';
import '../../view/widgets/ui_empty_png_screen.dart';
import '../../viewmodels/training_point/training_point_viewmodel.dart';

class TrainingPointsHistoryScreen extends StatefulWidget {
  const TrainingPointsHistoryScreen({Key? key, required this.email}) : super(key: key);
  final String email;

  @override
  _TrainingPointsHistoryScreenState createState() => _TrainingPointsHistoryScreenState();
}

class _TrainingPointsHistoryScreenState extends State<TrainingPointsHistoryScreen> {
  late TrainingPointViewModel viewModel;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    viewModel = TrainingPointViewModel(repository: TrainingPointRepository());

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      viewModel.onInitView(context);
      await viewModel.getTrainingPointAll(widget.email);
      await viewModel.getOpenTrainingPoint();
      await viewModel.getUser(widget.email);
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Scaffold(
        appBar: appBar(context, 'Lịch sử điểm rèn luyện'),
        body: Container(
          padding: EdgeInsets.symmetric(
            vertical: DimensManager.dimens.setHeight(14),
            horizontal: DimensManager.dimens.setWidth(14),
          ),
          child: isLoading
              ? _buildLoadingIndicator()
              : Selector<TrainingPointViewModel, List<TrainingPointModel?>?>(
                  selector: (_, viewModel) => viewModel.trainingPointAll,
                  builder: (context, value, child) {
                    if (viewModel.trainingPointAll?.isEmpty ?? true) {
                      return Column(
                        children: const [
                          SizedBox(
                            height: 200,
                          ),
                          UIEmptyPngScreen(
                            iconAsset: AppAssets.icHistoryMini,
                            title: "Hiện chưa có lịch sử điểm rèn luyện nào",
                          ),
                        ],
                      );
                    } else {
                      return ListView.builder(
                        itemCount: viewModel.trainingPointAll?.length,
                        itemBuilder: (context, index) {
                          if (viewModel.trainingPointAll?[index]?.history == true) {
                            return TrainingPointHistoryCard(
                              email: viewModel.user?.email ?? "",
                              permission: viewModel.user?.permission ?? "",
                              name: viewModel.user?.name ?? "",
                              score: viewModel.trainingPointAll?[index]?.teacherTrainingPoint ?? 0,
                              rank: viewModel.trainingPointAll?[index]?.teacherRank ?? "",
                              selfScoringScore:
                                  viewModel.trainingPointAll?[index]?.trainingPoint ?? 0,
                              teacherGrade:
                                  viewModel.trainingPointAll?[index]?.teacherTrainingPoint ?? 0,
                              scorer: viewModel.trainingPointAll?[index]?.gvcn ?? "",
                              semester: viewModel.trainingPointAll?[index]?.semester ?? "",
                              status: viewModel.trainingPointAll?[index]?.status ?? false,
                            );
                          } else {
                            return Container(); // Return an empty container when history is false
                          }
                        },
                      );
                    }
                  },
                ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(), // Hiển thị màn hình tải dữ liệu
    );
  }
}
