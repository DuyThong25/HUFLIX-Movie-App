import 'package:flutter/material.dart';
import 'package:huflix_movie_app/api/api.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class StatusBarDetail extends StatefulWidget {
  const StatusBarDetail({super.key, required this.idMovie});
  final int idMovie; // Thêm trường dữ liệu idMovie

  @override
  State<StatusBarDetail> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<StatusBarDetail> {

  late YoutubePlayerController _youtubePlayerController;
  late String _trailerVideoId;
  bool _trailerFound = false; // Thêm biến boolean để kiểm tra xem có trailer được tìm thấy không

  @override
  void initState(){
    super.initState();
    // Gọi phương thức để lấy thông tin trailer và xử lý kết quả
    Api().trailerMovieById(widget.idMovie).then((trailer) {
      for (final result in trailer.results!) {
        if (result.type == 'Trailer') {
          setState(() {
            _trailerFound = true;
            _trailerVideoId = result.key;
            _youtubePlayerController = YoutubePlayerController(
              initialVideoId: _trailerVideoId,
              flags: const YoutubePlayerFlags(
                autoPlay: true,
                mute: false,
              ),
            );
          });
          break; // Dừng vòng lặp khi tìm thấy trailer đầu tiên
        }
      }
    });
  }

  @override
  void dispose() {
    _youtubePlayerController.dispose();
    super.dispose();
  }

  void showVideoDialog() {
    if (_trailerFound) {
      // Chỉ hiển thị dialog nếu đã tìm thấy trailer
      showDialog(
        context: context, 
        builder: (_) => AlertDialog(
          content: Container(
            child: YoutubePlayer(
              controller: _youtubePlayerController,
              showVideoProgressIndicator: true,
              onReady: () {},
            ),
          ),
        )
      );
    } else {
      // Hiển thị AlertDialog thông báo rằng không có trailer
      showDialog(
        context: context, 
        builder: (_) => AlertDialog(
          content: Text("Phim này chưa có trailer"),
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
              padding: const EdgeInsets.all(8),
              color: const Color.fromARGB(255, 22, 18, 18), 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [ 
                  GestureDetector(
                    onTap: showVideoDialog,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          width: 4,
                          color: const Color.fromARGB(255, 128, 10, 2)
                        )
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 4, bottom: 4),
                          color:  const Color.fromARGB(255, 22, 18, 18),
                          child: const Text(
                            "TRAILER",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                      )),
                    ),
                  ),
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
                            Icons.play_arrow,
                            size: 20,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context, 
                              builder: (_) => const AlertDialog(
                                content: Text("Tính năng này đang cập nhật") ,
                              )
                            );
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
                            showDialog(
                              context: context, 
                              builder: (_) => const AlertDialog(
                                content: Text("Tính năng này đang cập nhật") ,
                              )
                            );
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
                            showDialog(
                              context: context, 
                              builder: (_) => const AlertDialog(
                                content: Text("Tính năng này đang cập nhật") ,
                              )
                            );
                          },
                        ),
                      ))
                ],
              ),
            )));
  }
}