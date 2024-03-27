import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:med_pocket/common/styles/styles.dart';
import 'package:med_pocket/controller/navigation_controller.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var user = Hive.box('user');

  XFile? selectedImage;
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  @override
  Widget build(BuildContext context) {
    NavigationController navigationController = Get.put(NavigationController());

    return Column(
      children: [
        Container(
          child: Row(
            children: [
              IconButton(
                icon: const Icon(
                  Iconsax.arrow_left_2,
                  color: Colors.red,
                ),
                onPressed: () {
                  navigationController.changePage(0);
                },
              ),
            ],
          ),
        ),
        Stack(children: [
          CircleAvatar(
            radius: 100,
            backgroundColor: Colors.white,
            child: user.get('image') == null
                ? _image == null
                    ? const Icon(
                        size: 100,
                        Iconsax.user,
                        color: Colors.red,
                      )
                    : ClipOval(
                        child: Image.file(
                          File(_image!.path),
                          fit: BoxFit.cover,
                          width: 200,
                          height: 200,
                        ),
                      )
                : ClipOval(
                    child: Image.file(
                      File(user.get('image')),
                      fit: BoxFit.cover,
                      width: 200,
                      height: 200,
                    ),
                  ),
          ),
          Positioned(
              bottom: 10,
              right: 10,
              child: GestureDetector(
                  onTap: selectImageFromGallery,
                  child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.pink.shade300,
                      child: const Icon(
                        Iconsax.gallery,
                        color: Colors.white,
                      )))),
        ]),
        const SizedBox(
          height: 30,
        ),
        Text(
          user.get('name'),
          style: headline(),
        ),
      ],
    );
  }

  Future selectImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    user.put('image', image!.path);

    setState(() {
      _image = image;
    });
  }
}
