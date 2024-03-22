import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_pocket/controller/navigation_controller.dart';
import 'package:med_pocket/pages/add/add_page.dart';
import 'package:med_pocket/pages/home/home_page.dart';
import 'package:med_pocket/pages/medicine/medicine_page.dart';
import 'package:med_pocket/pages/profile/profile_page.dart';
import 'package:med_pocket/common/styles/styles.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }

  List pages = [
    HomePage(),
    AddPage(),
    const MedicinePage(),
    const ProfilePage(),
  ];
  NavigationController navigationController = Get.put(NavigationController());
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: bgGradient(),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: Obx(() => pages[navigationController.selectedPage.value])),
        bottomNavigationBar: Obx(() {
          if (navigationController.selectedPage.value <= 2) {
            return Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: redGradient(),
                ),
                padding: const EdgeInsets.all(5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BottomNavigationBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    selectedItemColor: Colors.white,
                    unselectedItemColor:
                        const Color.fromARGB(255, 255, 173, 173),
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    currentIndex: navigationController.selectedPage.value,
                    onTap: (value) {
                      navigationController.changePage(value);
                    },
                    items: [
                      navItem(Iconsax.home),
                      navItem(Iconsax.add_square),
                      navItem(FontAwesomeIcons.pills),
                    ],
                  ),
                ));
          } else {
            return Container(
              height: 0,
            );
          }
        }),
      ),
    );
  }

  BottomNavigationBarItem navItem(IconData icon) =>
      BottomNavigationBarItem(icon: Icon(icon), label: "");
}
