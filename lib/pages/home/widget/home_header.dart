import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_pocket/controller/navigation_controller.dart';
import 'package:med_pocket/styles/styles.dart';

class HomeHeader extends StatelessWidget {
  HomeHeader({
    super.key,
    required this.navigationController,
  });

  final NavigationController navigationController;
  var user = Hive.box('user');


  @override
  Widget build(BuildContext context) {
    final name = user.get('name');
    final height = user.get('height');
    final weight = user.get('weight');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //--------- Name --------
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome back", style: headline(),),
            Text("Hi, $name", style: headline(w: FontWeight.w500),),
          ],
        ),
        // --------- Image --------
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.white,
          child: IconButton(onPressed:(){
            navigationController.changePage(3);
          }, icon: const Icon(Iconsax.user, color: Colors.red,),
          ),
        )
      ],
    );
  }
}
