import 'package:flutter/material.dart';

class TabViewData extends StatefulWidget {
  const TabViewData({super.key, required this.listData});
  final List<String> listData;

  @override
  State<TabViewData> createState() => _TabViewDataState();
}

class _TabViewDataState extends State<TabViewData> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: widget.listData.length,
            itemBuilder: ((context, index) {
              return itemListview(widget.listData[index]);
            })));
  }

  Widget itemListview(String item) {
    return Column(children: [
      Container(
        margin: const EdgeInsets.only(right: 30, left: 30, bottom: 12, top: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(26),
          child: Image.network(
            item,
            width: 160,
            height: 180,
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
      const Text(
        'TOM AND JERRY 2024',
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white70),
      )
    ]);
  }
}
