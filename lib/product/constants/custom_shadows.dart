import 'package:flutter/material.dart';

class CustomShadows {
  CustomShadows._();

  static List<Shadow> customLowShadow() => [
        Shadow(
          offset: const Offset(1.5, 1.5),
          blurRadius: 2,
          color: Colors.black.withOpacity(0.7),
        ),
      ];
}
