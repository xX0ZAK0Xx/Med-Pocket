import 'package:flutter/material.dart';
import 'package:med_pocket/common/styles/styles.dart';
import 'package:med_pocket/common/widgets/number_box.dart';

Future<dynamic> dialoge(BuildContext context, String title,
      TextEditingController controller, Function() save) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Center(child: Text(title)),
              actions: [
                NumberBox(hint: "", controller: controller),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        onPressed: () {
                          controller.clear();
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Cancel",
                          style: headline(
                              c: const Color.fromARGB(255, 255, 157, 150)),
                        )),
                    TextButton(
                        onPressed: () {
                          save();
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Save",
                          style: headline(),
                        ))
                  ],
                )
              ],
            ));
  }