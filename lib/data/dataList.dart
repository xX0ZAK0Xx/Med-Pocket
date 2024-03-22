import 'package:hive_flutter/hive_flutter.dart';

class DataList {
  static Box bmiBox = Hive.box('bmiList');
  static Box bloodo2Box = Hive.box('bloodo2');
  static Box bloodGlucoseBox = Hive.box('bloodGlucose');

  static List<List<dynamic>> allBMI = [];
  static List<dynamic> allBloodO2 = [];
  static List<dynamic> allBloodGlucose = [];
  static void fetchData() {
    allBMI = bmiBox.values.toList().cast<List<dynamic>>();
    allBloodGlucose = bloodGlucoseBox.values.toList().cast<List<dynamic>>();
    allBloodO2 = bloodo2Box.values.toList().cast<List<dynamic>>();
  }

  static void addBMI(List<dynamic> bmi) {
    bmiBox.add(bmi);
    allBMI.add(bmi);
  }
}
