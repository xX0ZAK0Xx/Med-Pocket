class Calculation {
  static double calculateBMI(String ft, String inch, String wt) {
    try {
      double weight = double.parse(wt);
      double height = double.parse(ft) * 0.3048 + double.parse(inch) * 0.0254;
      double bmi = weight / (height * height);

      // Round the BMI to one decimal point
      String roundedBMI = bmi.toStringAsFixed(1);
      bmi = double.parse(roundedBMI);
      return bmi;
      // ignore: empty_catches
    } catch (e) {
      return 0.0;
    }
  }
}
