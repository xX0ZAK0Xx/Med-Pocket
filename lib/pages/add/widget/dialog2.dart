import 'package:flutter/material.dart';
import 'package:med_pocket/common/styles/styles.dart';
import 'package:med_pocket/common/widgets/number_box.dart';

Future<dynamic> dialoge2(
      BuildContext context,
      String title,
      TextEditingController highController,
      TextEditingController lowController,
      Function() save) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Center(child: Text(title)),
              actions: [
                Row(
                  children: [
                    Expanded(
                        child: NumberBox(
                            hint: "High", controller: highController)),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child:
                            NumberBox(hint: "Low", controller: lowController)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        onPressed: () {
                          highController.clear();
                          lowController.clear();
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