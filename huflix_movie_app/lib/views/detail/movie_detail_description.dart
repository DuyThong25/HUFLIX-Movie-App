import 'package:flutter/material.dart';

import '../../common/common.dart';

class MovieDetalDescription extends StatefulWidget {
  const MovieDetalDescription({super.key, required this.description});
  final String description;

  @override
  State<MovieDetalDescription> createState() => _MovieDetalDescriptionState();
}

class _MovieDetalDescriptionState extends State<MovieDetalDescription> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          child: ConstrainedBox(
            constraints: isExpanded
                ? const BoxConstraints()
                : const BoxConstraints(maxHeight: 200),
            child: Text(
              widget.description,
              style: Common.styleDescriptionMovieDetail(),
              softWrap: true,
              overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
              maxLines: isExpanded ? null : 4,
            ),
          ),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          child: Text(
            isExpanded ? 'Thu gọn' : 'Đọc tiếp',
            style: const TextStyle(
              color: Color.fromARGB(255, 128, 10, 2),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          onTap: () => setState(() => isExpanded = !isExpanded),
        ),
      ],
    );
  }
}
