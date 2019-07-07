import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tencentmusician/api.dart';

class IndexChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (API().data.indexes.length == 0) {
      return Container();
    }
    List<FlSpot> spots = List.from(API().data.indexes.map(indexToFlSpot));

    List<Color> gradientColors = [
      Colors.blue,
      Colors.indigoAccent[700],
    ];
    return AspectRatio(
      aspectRatio: 1.70,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(right: 10, left: 0, top: 0, bottom: 0),
          child: FlChart(
            chart: LineChart(
              LineChartData(
                gridData: FlGridData(
                    show: true,
                    drawHorizontalGrid: false,
                    drawVerticalGrid: false,
                    verticalInterval: 1,
                    getDrawingVerticalGridLine: (value) {
                      return const FlLine(
                        color: Colors.black12,
                        strokeWidth: 1,
                      );
                    }),
                titlesData: FlTitlesData(
                  show: true,
                  horizontalTitlesTextStyle: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  getHorizontalTitles: (value) {
                    final date = DateTime.fromMillisecondsSinceEpoch(
                        (value * 300000000).toInt());
                    return '${date.month}.${date.day}';
                  },
                  verticalTitlesTextStyle: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  getVerticalTitles: (value) {
                    return value.toInt().toString();
                  },
                  verticalTitlesReservedWidth: 28,
                  verticalTitleMargin: 8,
                  horizontalTitleMargin: 8,
                ),
                borderData: FlBorderData(
                    show: false,
                    border: Border.all(color: Color(0xff37434d), width: 1)),
                minX: spots.first.x,
                maxX: spots.last.x,
                minY: spots.first.y - 0.2,
                maxY: spots.last.y + 0.2,
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    colors: gradientColors,
                    barWidth: 4,
                    isStrokeCapRound: true,
                    dotData: FlDotData(show: false),
                    belowBarData: BelowBarData(
                      show: true,
                      colors: gradientColors
                          .map((color) => color.withOpacity(0.2))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

FlSpot indexToFlSpot(IndexItem item) {
  double timestamp =
      (DateTime.parse(item.date).millisecondsSinceEpoch / 300000000);
  return FlSpot(timestamp, item.index);
}
