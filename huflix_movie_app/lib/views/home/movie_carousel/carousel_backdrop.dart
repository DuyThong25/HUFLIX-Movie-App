import 'package:blur/blur.dart';
import 'package:flutter/material.dart';

class CarouselBackdrop extends StatelessWidget {
  const CarouselBackdrop({super.key, required this.src});
  final String src;


  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: Blur(
        blur: 8,
        colorOpacity: 0.1,
        child: Image.network(
          fit: BoxFit.fitHeight,
          height: 400,
          src,
        ),
      ));
  }
}
