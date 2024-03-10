import 'package:flutter/material.dart';

class CarouselCard extends StatelessWidget {
  const CarouselCard({super.key, required this.src});
  final String src;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: Image.network(
                  fit: BoxFit.fitHeight,
                  width: 260,
                  height: 300,
                  src,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              // Data movie
              const Text(
                'TOM AND JERRY 2024',
                style: TextStyle(
                    fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              )
            ],
    ));
  }
}