import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:med_pocket/pages/createAccount/create_account.dart';
import 'package:med_pocket/pages/navigation/navigation_page.dart';
import 'package:med_pocket/common/styles/styles.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // await FullScreen.enterFullScreen(FullScreenMode.EMERSIVE_STICKY);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);



    var user = Hive.box('user');
    bool userExist = user.get('name') != null;

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              userExist ? const NavigationPage() : CreateAccount()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: bgGradient(),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'logo',
              child: Image.asset("assets/icons/medical-check.png")),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "MedP",
                  style: headline(s: 54.0),
                ),
                const SizedBox(width: 3,),
                LoadingAnimationWidget.beat(
                  size: 25,
                  color: Colors.red,
                ),
                const SizedBox(width: 3,),
                Text(
                  "cket",
                  style: headline(s: 54.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
