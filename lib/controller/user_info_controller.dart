import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserInfoController extends GetxController {
  var user = Hive.box('user');
  RxDouble bmi = 0.0.obs;
  void fetchBMI(){
    bmi.value = user.get('bmi') ?? 0.0;
  }
}
