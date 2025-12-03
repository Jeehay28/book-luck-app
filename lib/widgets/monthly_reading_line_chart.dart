import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MonthlyReadingData {
  final int month; // 1 ~ 12
  final double minutes; // reading time in hours
  MonthlyReadingData(this.month, this.minutes);

  // ✅ JSON → Model
  factory MonthlyReadingData.fromJson(Map<String, dynamic> json) {
    return MonthlyReadingData(
      json['month'] as int,
      (json['minutes'] as num).toDouble(),
    );
  }
}

class MonthlyReadingLineChart extends StatelessWidget {
  final List<MonthlyReadingData> data;

  const MonthlyReadingLineChart({
    super.key,
    required this.data,
  });

  double _calcMaxHours() {
    if (data.isEmpty) return 1.0;

    final maxMinutes =
        data.map((e) => e.minutes).reduce((a, b) => a > b ? a : b);
    final maxHours = maxMinutes / 60;

    // round up to nice 0.5 steps
    final rounded = (maxHours / 0.5).ceil() * 0.5;

    return rounded;
  }

  @override
  Widget build(BuildContext context) {
    final maxHours = _calcMaxHours();

    return SizedBox(
      height: 250,
      child: LineChart(
        LineChartData(
          minX: 1,
          maxX: 12,
          minY: 0,
          maxY: maxHours,

          borderData: FlBorderData(show: false),

          // Grid lines
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 2.5,
            getDrawingHorizontalLine: (value) => FlLine(
              color: const Color(0xff303030).withOpacity(0.2),
              strokeWidth: 1,
            ),
          ),

          // Axis titles
          titlesData: FlTitlesData(
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                interval: 2.5,
                getTitlesWidget: (value, _) {
                  if (value == 0) return const SizedBox.shrink();
                  return Text(
                    "${value.toStringAsFixed(value % 1 == 0 ? 0 : 1)}h",
                    style: const TextStyle(fontSize: 11),
                  );
                },
              ),
            ),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 10), // <-- add padding ABOVE label
                    child: Text(
                      "${value.toInt()}월",
                      style: const TextStyle(fontSize: 11),
                    ),
                  );
                },
              ),
            ),
          ),

          lineBarsData: [
            LineChartBarData(
              spots: data
                  .map((d) => FlSpot(d.month.toDouble(), d.minutes / 60))
                  .toList(),

              isCurved: true, // smooth line
              barWidth: 3,
              // color: const Color(0xFF15B67C),
              //
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFE53935), // red
                  Color(0xFFFFA726), // orange
                  Color(0xFFFFEB3B), // yellow
                  Color(0xFF66BB6A), // green
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: 4,
                    color: Colors.black, // <-- DOT COLOR
                    strokeWidth: 0,
                  );
                },
              ), // show dots
              belowBarData: BarAreaData(
                show: false,
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF15B67C).withOpacity(0.3),
                    const Color(0xFF15B67C).withOpacity(0.0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
