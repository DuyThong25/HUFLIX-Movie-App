import 'package:flutter/material.dart';

import '../../common/common.dart';

class MovieDetalDescription extends StatefulWidget {
  const MovieDetalDescription({super.key, required this.description});
  final String description;

  @override
  State<MovieDetalDescription> createState() => _MovieDetalDescriptionState();
}

class _MovieDetalDescriptionState extends State<MovieDetalDescription>
    with TickerProviderStateMixin {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, 
      children: [
      AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: ConstrainedBox(
              constraints: isExpanded
                  ? const BoxConstraints()
                  : const BoxConstraints(maxHeight: 100),
              child: Text(
                widget.description,
                style: Common.styleDescriptionMovieDetail(),
                softWrap: true,
                overflow: TextOverflow.fade,
              ))),
              SizedBox(height: 10,)
              ,
      isExpanded
          ? GestureDetector(
              // icon: const Icon(Icons.arrow_upward, color: Color.fromARGB(255, 128, 10, 2)),
              child: const Text('Thu gon', style: TextStyle(color: Color.fromARGB(255, 128, 10, 2), fontWeight: FontWeight.bold, fontSize: 15, ),),
              onTap: () => setState(() => isExpanded = false))
          : GestureDetector(
              child: const Text('Đọc tiếp', style: TextStyle(color: Color.fromARGB(255, 128, 10, 2), fontWeight: FontWeight.bold, fontSize: 15),),
              onTap: () => setState(() => isExpanded = true))
    ]);
  }
}
