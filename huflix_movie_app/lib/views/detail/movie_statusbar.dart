import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// class StatusBarDetail extends StatelessWidget {
//   const StatusBarDetail({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         color: Colors.transparent,
//         child: ClipRRect(
//             borderRadius: BorderRadius.circular(50),
//             child: Container(
//               padding: const EdgeInsets.all(8),
//               color: Colors.black,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   // button
//                   Container(
//                       width: 40,
//                       height: 40,
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                             width: 4,
//                             color: const Color.fromARGB(255, 128, 10, 2)),
//                         shape: BoxShape.circle,
//                       ),
//                       child: Center(
//                         child: IconButton(
//                           padding: EdgeInsets.zero,
//                           icon: const Icon(
//                             Icons.play_arrow_outlined,
//                             color: Colors.white,
//                             // size: 32,
//                           ),
//                           onPressed: () {
//                             // Your event handler
//                           },
//                         ),
//                       )),
//                   // button
//                   Container(
//                       width: 40,
//                       height: 40,
//                       // margin: EdgeInsets.zero,
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                             width: 4,
//                             color: const Color.fromARGB(255, 128, 10, 2)),
//                         shape: BoxShape.circle,
//                       ),
//                       child: Center(
//                         child: IconButton(
//                           padding: EdgeInsets.zero,
//                           icon: const Icon(
//                             Icons.thumb_up_alt_outlined,
//                             size: 20,
//                             color: Colors.white,
//                           ),
//                           onPressed: () {
//                             // Your event handler
//                           },
//                         ),
//                       )),
//                   // button 3
//                   Container(
//                       width: 40,
//                       height: 40,
//                       // margin: EdgeInsets.zero,
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                             width: 4,
//                             color: const Color.fromARGB(255, 128, 10, 2)),
//                         shape: BoxShape.circle,
//                       ),
//                       child: Center(
//                         child: IconButton(
//                           padding: EdgeInsets.zero,
//                           icon: const Icon(
//                             Icons.share,
//                             size: 20,
//                             color: Colors.white,
//                           ),
//                           onPressed: () {
//                             // Your event handler
//                           },
//                         ),
//                       )),
//                   // button 4
//                   Container(
//                       width: 40,
//                       height: 40,
//                       // margin: EdgeInsets.zero,
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                             width: 4,
//                             color: const Color.fromARGB(255, 128, 10, 2)),
//                         shape: BoxShape.circle,
//                       ),
//                       child: Center(
//                         child: IconButton(
//                           padding: EdgeInsets.zero,
//                           icon: const Icon(
//                             Icons.download_outlined,
//                             color: Colors.white,
//                           ),
//                           onPressed: () {
//                             // Your event handler
//                           },
//                         ),
//                       ))
//                 ],
//               ),
//             )));
//   }
// }

class StatusBarDetail extends StatefulWidget {
  const StatusBarDetail({super.key});

  @override
  State<StatusBarDetail> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<StatusBarDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
              padding: const EdgeInsets.all(8),
              color: Color.fromARGB(255, 22, 18, 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // button
                  Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 4,
                            color: const Color.fromARGB(255, 128, 10, 2)),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(
                            Icons.play_arrow_outlined,
                            color: Colors.white,
                            // size: 32,
                          ),
                          onPressed: () {
                            // Your event handler
                          },
                        ),
                      )),
                  // button
                  Container(
                      width: 40,
                      height: 40,
                      // margin: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 4,
                            color: const Color.fromARGB(255, 128, 10, 2)),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(
                            Icons.thumb_up_alt_outlined,
                            size: 20,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            // Your event handler
                          },
                        ),
                      )),
                  // button 3
                  Container(
                      width: 40,
                      height: 40,
                      // margin: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 4,
                            color: const Color.fromARGB(255, 128, 10, 2)),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(
                            Icons.share,
                            size: 20,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            // Your event handler
                          },
                        ),
                      )),
                  // button 4
                  Container(
                      width: 40,
                      height: 40,
                      // margin: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 4,
                            color: const Color.fromARGB(255, 128, 10, 2)),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(
                            Icons.download_outlined,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            // Your event handler
                          },
                        ),
                      ))
                ],
              ),
            )));
  }
}