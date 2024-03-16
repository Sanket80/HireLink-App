import 'package:hirelink/Bar%20Graph/individual_bar.dart';

class BarData{
  final double webDeveloper;
  final double mobileDeveloper;
  final double softwareDeveloper;
  final double dataScientist;
  final double devOps;

  BarData({
    required this.webDeveloper,
    required this.mobileDeveloper,
    required this.softwareDeveloper,
    required this.dataScientist,
    required this.devOps,
  });

  List<IndividualBar> barData =[];

  void setBarData(){
    barData = [
      IndividualBar(x: 0, y: webDeveloper),
      IndividualBar(x: 1, y: mobileDeveloper),
      IndividualBar(x: 2, y: softwareDeveloper),
      IndividualBar(x: 3, y: dataScientist),
      IndividualBar(x: 4, y: devOps),
    ];
  }


}