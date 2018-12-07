import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class CircularChart1 extends StatelessWidget {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();
  final dynamic completedColor;
  final dynamic uncompletedColor;
  final double taskDone;
  final double taskUnDone;
  static var i;

  CircularChart1({
    this.taskDone,
    this.taskUnDone,
    this.completedColor,
    this.uncompletedColor,
  });

  @override
  Widget build(BuildContext context) {
    int percentage = ((taskDone / (taskDone + taskUnDone)) * 100).toInt();
    return new Container(
      child: new AnimatedCircularChart(
        key: _chartKey,
        size: const Size(90.0, 90.0),
        initialChartData: [
          new CircularStackEntry(
            <CircularSegmentEntry>[
              new CircularSegmentEntry(taskDone, completedColor, rankKey: 'Q1'),
              new CircularSegmentEntry(taskUnDone, uncompletedColor,
                  rankKey: 'Q2'),
            ],
            rankKey: 'Quarterly Profits',
          ),
        ],
        holeLabel: '$percentage %',
        labelStyle: new TextStyle(
          color: Colors.white,
        ),
        chartType: CircularChartType.Radial,
      ),
    );
  }
}
