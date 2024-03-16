import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hirelink/Bar%20Graph/bar_data.dart';

class MyBarGraph extends StatelessWidget {
  final List<double> salary;
  const MyBarGraph({super.key, required this.salary});

  @override
  Widget build(BuildContext context) {

    BarData mybarData = BarData(
      webDeveloper: salary[0],
      mobileDeveloper: salary[1],
      softwareDeveloper: salary[2],
      dataScientist: salary[3],
      devOps: salary[4],
    );
    mybarData.setBarData();

    return BarChart(
      BarChartData(
        minY: 0,
        maxY: 10000,
        titlesData: FlTitlesData(
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),

          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: getBottomTitles,
            ),
          ),
        ),

        barGroups: mybarData.barData
            .map(
              (data) => BarChartGroupData(
                x: data.x,
                barRods: [
                  BarChartRodData(
                    toY: data.y,
                    color: Color(0xffe11d48),
                    width: 25,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ],
              ),
            )
            .toList(),
      )
    );
  }
}

Widget getBottomTitles(double value, TitleMeta meta){
  const style = TextStyle(
    color: Color(0xff7589a2),
    fontSize: 10,
  );

  Widget text;
  switch (value.toInt()) {
    case 0:
      text = Text('Web', style: style);
      break;
    case 1:
      text = Text('Mobile', style: style);
      break;
    case 2:
      text = Text('Software', style: style);
      break;
    case 3:
      text = Text('Data', style: style);
      break;
    case 4:
      text = Text('DevOps', style: style);
      break;
    default:
      text = Text('Other', style: style);
      break;
  }
  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}
