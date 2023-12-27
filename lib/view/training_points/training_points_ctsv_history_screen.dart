import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/training_point_model.dart';
import '../../models/user_model.dart';
import '../../repository/training_point_repository.dart';
import '../../res/constant/app_assets.dart';
import '../../utils/dimens/dimens_manager.dart';
import '../../view/training_points/widget/training_point_history_card.dart';
import '../../view/widgets/appbar.dart';
import '../../view/widgets/ui_empty_png_screen.dart';
import '../../view/widgets/ui_search_input.dart';
import '../../viewmodels/training_point/training_point_viewmodel.dart';

class TrainingPointsCtsvHistoryScreen extends StatefulWidget {
  const TrainingPointsCtsvHistoryScreen({Key? key}) : super(key: key);

  @override
  _TrainingPointsCtsvHistoryScreenState createState() => _TrainingPointsCtsvHistoryScreenState();
}

class _TrainingPointsCtsvHistoryScreenState extends State<TrainingPointsCtsvHistoryScreen> {
  late TrainingPointViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = TrainingPointViewModel(repository: TrainingPointRepository());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.onInitView(context);
      viewModel.getListTrainingPoint();
      viewModel.getOpenTrainingPoint();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Scaffold(
        appBar: appBar(context, 'Danh sách lịch sử điểm rèn luyện'),
        body: Column(
          children: [
            Container(
              color: Colors.white,
              width: DimensManager.dimens.setWidth(390),
              height: DimensManager.dimens.setHeight(48),
              child: UISearchInput(
                onChangeValue: (String value) {
                  null;
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: DimensManager.dimens.setHeight(14),
                  horizontal: DimensManager.dimens.setWidth(14),
                ),
                child: Selector<TrainingPointViewModel, List<TrainingPointModel?>?>(
                  selector: (_, viewModel) => viewModel.listTrainingPoint,
                  builder: (context, listTrainingPoint, child) {
                    if (listTrainingPoint?.isNotEmpty ?? false) {
                      return ListView.builder(
                        itemCount: listTrainingPoint?.length,
                        itemBuilder: (context, index) {
                          final trainingPoint = listTrainingPoint?[index];
                          final email = trainingPoint?.email ?? "";

                          return FutureBuilder<UsersModel?>(
                            future: viewModel.getUser(email),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }

                              if (snapshot.hasError) {
                                return Text('Đã xảy ra lỗi: ${snapshot.error}');
                              }

                              final user = snapshot.data;

                              if (trainingPoint?.history == true && user != null) {
                                return TrainingPointHistoryCard(
                                  email: user.email ?? "",
                                  permission: "ctsv",
                                  name: user.name ?? "",
                                  score: trainingPoint?.teacherTrainingPoint ?? 0,
                                  rank: trainingPoint?.teacherRank ?? "",
                                  selfScoringScore: trainingPoint?.trainingPoint ?? 0,
                                  teacherGrade: trainingPoint?.teacherTrainingPoint ?? 0,
                                  scorer: trainingPoint?.gvcn ?? "",
                                  semester: trainingPoint?.semester ?? "",
                                  status: trainingPoint?.status ?? false,
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            },
                          );
                        },
                      );
                    } else {
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
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
