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
      showModalBottomSheet(
        backgroundColor: Colors.black,
        isScrollControlled: true,
        context: context, 
        builder: (BuildContext context) {
          return Container(
                // height: 500,
                // color: Colors.black,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      YoutubePlayer(
                            controller: _youtubePlayerController,
                            showVideoProgressIndicator: true,
                            onReady: () {},
                          ),
                      const SizedBox(height: 32,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, 
                          backgroundColor: Colors.black, // Màu chữ
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.white), // Viền màu trắng
                            borderRadius: BorderRadius.circular(8), // Độ cong viền
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: Text('Đóng'),
                      ),
                    ],
                  ),
                ),
              );
        }
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
                            showVideoDialog();
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
                            Icons.thumb_up_outlined,
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
                            Icons.thumb_down_outlined,
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
                      )),

                ],
              ),
            )));
  }
}