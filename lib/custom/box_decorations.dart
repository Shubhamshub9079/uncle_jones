import 'package:flutter/material.dart';
import 'package:UncleJons/my_theme.dart';

class BoxDecorations {
  static BoxDecoration buildBoxDecoration_2({double radius = 6.0}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      color: Colors.transparent,
      border: Border.all(),
    );
  }

  static BoxDecoration buildBoxDecoration_1({double radius = 10.0}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.12),
          blurRadius: 20,
          spreadRadius: 0.0,
          offset: Offset(0.0, 5.0), // shadow direction: bottom right
        )
      ],
    );
  }

  static BoxDecoration buildCartCircularButtonDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(16.0),
      color: Color.fromRGBO(229, 241, 248, 1),
    );
  }

  static BoxDecoration buildCircularButtonDecoration_1() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(36.0),
      color: Color(0xffFFADBB),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.08),
          blurRadius: 20,
          spreadRadius: 0.0,
          offset: Offset(0.0, 10.0), // shadow direction: bottom right
        )
      ],
    );
  }
}
