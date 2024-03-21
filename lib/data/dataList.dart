import 'package:hive_flutter/hive_flutter.dart';

class DataList {
  static Box bmiBox = Hive.box('bmiList');
  static List<List<dynamic>> allBMI = [];
  static void fetchData(){
    allBMI = bmiBox.values.toList().cast<List<dynamic>>();
  }
  DataList() {
    allBMI = bmiBox.values.toList().cast<List<dynamic>>();
  }

  static void addBMI(List<dynamic> bmi) {
    bmiBox.add(bmi);
    allBMI.add(bmi);
  }
}
