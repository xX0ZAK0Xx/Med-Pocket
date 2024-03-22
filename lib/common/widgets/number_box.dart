import 'package:flutter/material.dart';

class NumberBox extends StatelessWidget {
  const NumberBox({
    super.key,
    required this.hint,
    required this.controller,
  });
  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      cursorColor: Colors.red,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade50, width: 1),
            borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade100, width: 1),
            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
