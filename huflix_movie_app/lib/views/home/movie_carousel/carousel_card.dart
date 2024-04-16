import 'package:flutter/material.dart';

import '../../../common/common.dart';

class CarouselCard extends StatelessWidget {
  const CarouselCard({super.key, required this.src, required this.movieTitle});
  final String src;
  final String movieTitle;

  @override
  Widget build(BuildContext context) {
    double scrwidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(28.0)),
              boxShadow: [
                BoxShadow(
                    blurRadius: 16, color: Colors.black54, offset: Offset(2, 2))
              ]),
          child: scrwidth < 700
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(28.0),
                  child: Image.network(
                    fit: BoxFit.fill,
                    width: 240,
                    height: 300,
                    src,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      'assets/images/logo2.jpg',
                      fit: BoxFit.fill,
                      width: 240,
                      height: 300,
                    ),
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(28.0),
                  child: Image.network(
                    fit: BoxFit.fill,
                    width: 180,
                    height: 240,
                    src,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      'assets/images/logo2.jpg',
                      fit: BoxFit.fill,
                      width: 180,
                      height: 240,
                    ),
                  ),
                ),
        ),

        const SizedBox(
          height: 20,
        ),
        // Data movie
        Text(
          Common.shortenTitleCardCarousel(movieTitle),
          // movieTitle,
          style: const TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Container(
            margin: const EdgeInsets.only(top: 6),
            height: 5,
            width: 100,
            decoration: const BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      color: Colors.white38,
                      offset: Offset(2, 2))
                ]))
      ],
    );
  }
}
