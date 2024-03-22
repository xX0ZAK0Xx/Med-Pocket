
import 'package:flutter/material.dart';
import 'package:med_pocket/common/widgets/number_box.dart';

class GetHeight extends StatelessWidget {
  const GetHeight({
    super.key,
    required this.heightFTController,
    required this.heightINController,
  });

  final TextEditingController heightFTController;
  final TextEditingController heightINController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Height:  ",
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(
          width: 80,
          child: NumberBox(
            hint: "",
            controller: heightFTController,
          ),
        ),
        const Text(
          "ft",
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(
          width: 80,
          child: NumberBox(
            hint: "",
            controller: heightINController,
          ),
        ),
        const Text(
          "inch",
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
