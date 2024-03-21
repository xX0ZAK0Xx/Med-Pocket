import 'package:flutter/material.dart';

TextStyle headline({c = Colors.red, s = 24.0, w = FontWeight.bold}) =>
    TextStyle(color: c, fontSize: s, fontWeight: w);

LinearGradient redGradient() => const LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
        colors: [
          Colors.pink,
          Colors.red,
        ]);

LinearGradient bgGradient() => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromARGB(255, 255, 227, 236),
          Color.fromARGB(255, 221, 240, 255)
        ]);
