// import 'package:flutter/material.dart';
// import 'package:huflix_movie_app/common/common.dart';

// class Member extends StatelessWidget {
//   const Member({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Flexible(
//       child: Container(
//         color: Colors.black,
//         child: TabBarView(
//           children: [
//             ListView.builder(
//               shrinkWrap: true,
//               scrollDirection: Axis.horizontal,
//                 padding: const EdgeInsets.all(8),
//                 itemCount: 1,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Container(
//                       height: 50,
//                       color: Colors.amber,
//                       child: Center(
//                         child: Container(
//                           margin: const EdgeInsets.only(right: 20),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(26),
//                                 child: Image.asset(
//                                   'assets/images/duythong.jpg',
//                                   width: 160,
//                                   height: 180,
//                                   fit: BoxFit.cover,
//                                   alignment: Alignment.topCenter,
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               Text(
//                                 Common.shortenTitleTab('Duy Thong'),
//                                 style: const TextStyle(
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ));
//                 }),
                
//           ],
//         ),
//       ),
//     );
//   }
// }
