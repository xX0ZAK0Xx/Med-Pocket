import 'package:get/get.dart';

class DropDownController extends GetxController {
  RxString time = ''.obs;
  
  void setTime(value) {
    time.value = value;
  }
}