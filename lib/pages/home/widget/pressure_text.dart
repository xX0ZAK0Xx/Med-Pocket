
import 'package:flutter/widgets.dart';
import 'package:med_pocket/styles/styles.dart';

class PressureText extends StatelessWidget {
  const PressureText({
    super.key,
    required this.value,
  });

  final int value;

  @override
  Widget build(BuildContext context) {
    return Text(
      value.toString(),
      style: headline(
              c: const Color.fromARGB(255, 152, 64, 247), s: 34.0)
          .copyWith(shadows: [
        const Shadow(
            offset: Offset(0.0, 0.0),
            blurRadius: 50.0,
            color: Color.fromARGB(87, 152, 64, 247)),
      ]),
    );
  }
}

