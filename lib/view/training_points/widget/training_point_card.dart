import 'package:flutter/material.dart';

import '../../../res/style/app_colors.dart';
import '../../../utils/dimens/dimens_manager.dart';
import '../../../view/widgets/ui_text.dart';

const double kNormalHeight = 98.0;

class TrainingPointCard extends StatefulWidget {
  final String name;
  final String semester;
  final int score;
  final String rank;
  final bool status;

  const TrainingPointCard({
    super.key,
    required this.name,
    required this.semester,
    required this.score,
    required this.rank,
    required this.status,
  });

  @override
  State<TrainingPointCard> createState() => _TrainingPointCardState();
}

class _TrainingPointCardState extends State<TrainingPointCard> {
  double height = kNormalHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16.0,
          ),
        ],
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
        child: ClipPath(
          clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          )),
          child: Stack(
            children: [
              AnimatedContainer(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                duration: const Duration(milliseconds: 300),
                height: height,
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                        color: widget.status ? AppColors.primaryColor : AppColors.errorMsg,
                        width: 8),
                  ),
                ),
                child: _buildShortInfo(widget.name, widget.semester, widget.score, widget.rank),
              ),
              Positioned(
                left: 4,
                child: ClipPath(
                  clipper: ShapeBorderClipper(
                      shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  )),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: height,
                    decoration: const BoxDecoration(
                      border: Border(left: BorderSide(color: Colors.white, width: 10)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _buildShortInfo(String name, String semester, int score, String rank) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          width: 12,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UIText(
                  "Sinh viên: $name",
                  style: const TextStyle(fontSize: 15, color: Color(0xFF434343)),
                ),
                Row(
                  children: [
                    UIText(
                      "Học kì: $semester",
                      style: const TextStyle(fontSize: 15, color: Color(0xFF434343)),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: DimensManager.dimens.setHeight(14),
            ),
            UIText(
              "Tổng điểm: $score",
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
            ),
            const SizedBox(
              height: 8,
            ),
            UIText(
              "Xếp loại: $rank",
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
            ),
          ],
        ),
      ],
    );
  }
}
