import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_pocket/controller/navigation_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    NavigationController navigationController = Get.put(NavigationController());

    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.bottomLeft,
                  colors: [
                Colors.pink,
                Colors.red,
              ])),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Iconsax.direct_left, color: Colors.white,),
                onPressed: () {
                  navigationController.changePage(0);
                },
              ),
              const Text("Profile"),
            ],
          ),
        ),
        Container(
          child: const Text("Profile Page"),
        ),
      ],
    );
  }
}
