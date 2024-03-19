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
          child: 
          Image.network(
            fit: BoxFit.fill,
            width: double.infinity,
            height: 400,
            src,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset('assets/images/logo2.jpg', fit: BoxFit.fill, width: double.infinity, height: 400,);
            },
          ) ,
        ));
  }
}
