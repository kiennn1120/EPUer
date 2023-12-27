import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../models/scholarship_model.dart';
import '../../view/widgets/ui_text.dart';

class PieChartScholarship extends StatefulWidget {
  const PieChartScholarship({Key? key}) : super(key: key);

  @override
  _PieChartScholarshipState createState() => _PieChartScholarshipState();
}

class _PieChartScholarshipState extends State<PieChartScholarship> {
  late List<ScholarshipModel> scholarships = [];
  int touchedIndex = -1;
  int excellentScholarshipCount = 0;
  int goodScholarshipCount = 0;
  int outstandingScholarshipCount = 0;

  @override
  void initState() {
    super.initState();
    fetchScholarships();
  }

  Future<void> fetchScholarships() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('scholarships').get();
    final List<ScholarshipModel> scholarshipList =
        snapshot.docs.map((doc) => ScholarshipModel.fromFirestore(doc, null)).toList();
    setState(() {
      scholarships = scholarshipList;
      excellentScholarshipCount = countScholarshipsByRank(scholarshipList, 'Giỏi');
      goodScholarshipCount = countScholarshipsByRank(scholarshipList, 'Khá');
      outstandingScholarshipCount = countScholarshipsByRank(scholarshipList, 'Xuất Sắc');
    });
  }

  int countScholarshipsByRank(List<ScholarshipModel> scholarshipList, String rank) {
    int count = 0;
    for (final scholarship in scholarshipList) {
      if (scholarship.rank == rank) {
        count++;
      }
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thống kê'),
      ),
      body: scholarships.isNotEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: UIText(
                    "Thống kê học bổng",
                  ),
                ),
                AspectRatio(
                  aspectRatio: 1.3,
                  child: Row(
                    children: <Widget>[
                      const SizedBox(height: 18),
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: PieChart(
                            PieChartData(
                              pieTouchData: PieTouchData(
                                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                  setState(() {
                                    if (!event.isInterestedForInteractions ||
                                        pieTouchResponse == null ||
                                        pieTouchResponse.touchedSection == null) {
                                      touchedIndex = -1;
                                      return;
                                    }
                                    touchedIndex =
                                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                                  });
                                },
                              ),
                              borderData: FlBorderData(show: false),
                              sectionsSpace: 0,
                              centerSpaceRadius: 40,
                              sections: getSections(),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Indicator(
                            color: Colors.blue,
                            text: 'Khá',
                            isSquare: true,
                          ),
                          SizedBox(height: 4),
                          Indicator(
                            color: Colors.orange,
                            text: 'Giỏi',
                            isSquare: true,
                          ),
                          SizedBox(height: 4),
                          Indicator(
                            color: Colors.purple,
                            text: 'Xuất sắc',
                            isSquare: true,
                          ),
                          SizedBox(height: 18),
                        ],
                      ),
                      const SizedBox(width: 28),
                    ],
                  ),
                ),
                UIText(
                  "     Sinh viên nhận học bổng loại khá: $goodScholarshipCount",
                ),
                const SizedBox(height: 4),
                UIText(
                  "     Sinh viên nhận học bổng loại giỏi: $excellentScholarshipCount",
                ),
                const SizedBox(height: 4),
                UIText(
                  "     Sinh viên nhận học bổng loại xuất sắc: $outstandingScholarshipCount",
                ),
                const SizedBox(height: 4),
                UIText(
                  "     Tổng sinh viên nhận học bổng: ${outstandingScholarshipCount + excellentScholarshipCount + outstandingScholarshipCount}",
                ),
                const SizedBox(height: 4),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  List<PieChartSectionData> getSections() {
    final List<Color> sectionColors = [
      Colors.blue,
      Colors.orange,
      Colors.purple,
    ];

    final Map<String, int> rankCount = {
      'Khá': 0,
      'Giỏi': 0,
      'Xuất Sắc': 0,
    };

    for (final scholarship in scholarships) {
      if (rankCount.containsKey(scholarship.rank)) {
        rankCount[scholarship.rank!] = (rankCount[scholarship.rank] ?? 0) + 1;
      }
    }

    int totalCount = scholarships.length;

    return rankCount.entries.map((entry) {
      final String rank = entry.key;
      final int count = entry.value;
      final double percentage = count / totalCount;

      return PieChartSectionData(
        color: getSectionColor(rank),
        value: percentage,
        title: '${(percentage * 100).toStringAsFixed(1)}%',
        radius: 50,
        titleStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  Color getSectionColor(String rank) {
    switch (rank) {
      case 'Khá':
        return Colors.blue;
      case 'Giỏi':
        return Colors.orange;
      case 'Xuất Sắc':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;

  const Indicator({
    Key? key,
    required this.color,
    required this.text,
    this.isSquare = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
