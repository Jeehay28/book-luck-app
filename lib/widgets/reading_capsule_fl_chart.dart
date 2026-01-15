import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math'; // 👈 max() 쓰려고 필요

class ReadingData {
  final String date;
  final double hours;

  ReadingData(this.date, this.hours);

// JSON → Model
  factory ReadingData.fromJson(Map<String, dynamic> json) {
    return ReadingData(
      json['date'] as String,
      (json['hours'] as num).toDouble(),
    );
  }
}

class ReadingCapsuleFlChart extends StatelessWidget {
  final List<ReadingData> data;

  const ReadingCapsuleFlChart({
    super.key,
    required this.data,
  });

  double _calcMaxHours() {
    if (data.isEmpty) return 0.5;

    final rawMax = data.map((e) => e.hours).reduce(max);

    // 0.5 단위로 올림 (ex. 1.1 -> 1.5, 2.01 -> 2.5)
    final rounded = (rawMax / 0.5).ceil() * 0.5;

    // 최소 0.5
    return max(0.5, rounded);
  }

  @override
  Widget build(BuildContext context) {
    final maxHours = _calcMaxHours();

    return SizedBox(
      height: 180,
      child: BarChart(
        BarChartData(
          maxY: maxHours,
          minY: 0,
          borderData: FlBorderData(show: false),

          // 가로 그리드
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 0.5,
            getDrawingHorizontalLine: (value) => FlLine(
              color: const Color(0xff303030).withOpacity(0.4),
              strokeWidth: 1,
            ),
          ),

          titlesData: FlTitlesData(
            leftTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),

            // 오른쪽 Y 라벨: 0.5, 1, 1.5, 2, 2.5 ...
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 0.5,
                reservedSize: 38,
                getTitlesWidget: (value, meta) {
                  if (value == 0) return const SizedBox.shrink(); // 0은 숨기기 옵션

                  final text = value % 1 == 0
                      ? value.toStringAsFixed(0) // 정수면 1,2,3
                      : value.toStringAsFixed(1); // 소수면 0.5, 1.5 ...

                  return Text(
                    '${text}h',
                    style: const TextStyle(fontSize: 10),
                  );
                },
              ),
            ),

            // 아래 X 라벨: 날짜
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 28,
                getTitlesWidget: (value, meta) {
                  final i = value.toInt();
                  if (i < 0 || i >= data.length) {
                    return const SizedBox.shrink();
                  }
                  return Text(
                    data[i].date,
                    style: const TextStyle(fontSize: 10),
                  );
                },
              ),
            ),
          ),

          barGroups: _buildBarGroups(maxHours),
          barTouchData: BarTouchData(enabled: false),
        ),
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups(double maxHours) {
    return List.generate(data.length, (i) {
      final d = data[i];

      return BarChartGroupData(
        x: i,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
            // ❗️캡슐 아웃라인 높이는 항상 maxHours → 모두 같은 높이
            toY: maxHours,
            width: 18,

            // 검정 테두리 캡슐
            borderSide: const BorderSide(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(999), // 상하 라운드

            // 내부: 아래는 초록, 위는 흰색
            rodStackItems: [
              BarChartRodStackItem(0, d.hours, const Color(0xFF058E60)),
              BarChartRodStackItem(d.hours, maxHours, Colors.white),
            ],
          ),
        ],
      );
    });
  }
}
