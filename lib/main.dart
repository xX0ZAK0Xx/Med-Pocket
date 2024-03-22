import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:med_pocket/data/dataList.dart';
import 'package:med_pocket/pages/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  var user = await Hive.openBox('user');
  var bmiList = await Hive.openBox('bmiList');
  var bloodo2 = await Hive.openBox('bloodo2');
  var bloodGlucose = await Hive.openBox('bloodGlucose');

  DataList.fetchData();
  // user.clear();
  // bmiList.clear();
  // bloodo2.clear();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: const SplashScreen(),
    themeMode: ThemeMode.light,
    theme: ThemeData(fontFamily: 'Poppins'),
  ));
}
