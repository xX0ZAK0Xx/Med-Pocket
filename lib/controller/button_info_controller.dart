import 'package:get/get.dart';

class ButtonInfoController extends GetxController {
  RxDouble bloodO2 = 0.0.obs;
  RxDouble bloodGlucose = 0.0.obs;
  RxInt highPressure = 0.obs;
  RxInt lowPressure = 0.obs;



  void changeBloodO2(double value){
    bloodO2.value = value;
  }
  void changeBloodGlucose(double value){
    bloodGlucose.value = value;
  }
  void changePressure(int value1, int value2){
    highPressure.value = value1;
    lowPressure.value = value2;
  }
}
