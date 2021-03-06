import 'package:flutter/material.dart';

class MyClipper extends CustomClipper<Path> {
  int size;
  MyClipper({required this.size});
  @override
  Path getClip(Size size) {
    final p = Path();

    p.lineTo(0, size.height);
    p.lineTo(size.width, size.height);

    p.lineTo(size.width, 0);

    p.close();

    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
