import 'package:hive_flutter/hive_flutter.dart';

class DataList {
  static Box bmiBox = Hive.box('bmiList');
  static Box bloodo2Box = Hive.box('bloodo2');
  static Box bloodGlucoseBox = Hive.box('bloodGlucose');
  static Box pressureBox = Hive.box('pressure');

  static List<List<dynamic>> allBMI = [];
  static List<double> allBloodO2 = [];
  static List<double> allBloodGlucose = [];
  static List<List<int>> allPressure = [];
  static void fetchData() {
    allBMI = bmiBox.values.toList().cast<List<dynamic>>();
    allBloodGlucose = bloodGlucoseBox.values.toList().cast<double>();
    allBloodO2 = bloodo2Box.values.toList().cast<double>();
    allPressure = pressureBox.values.toList().cast<List<int>>();
  }

  static void addBMI(List<dynamic> bmi) {
    bmiBox.add(bmi);
    allBMI.add(bmi);
  }

  static void addBloodO2(double bloodo2) {
    bloodo2Box.add(bloodo2);
    allBloodO2.add(bloodo2);
  }

  static void addBloodGlucose(double bloodGlucose) {
    bloodGlucoseBox.add(bloodGlucose);
    allBloodGlucose.add(bloodGlucose);
  }

  static void addPressure(int highValue, int lowValue) {
    pressureBox.add([highValue, lowValue]);
    allPressure.add([highValue, lowValue]);
  }
}
