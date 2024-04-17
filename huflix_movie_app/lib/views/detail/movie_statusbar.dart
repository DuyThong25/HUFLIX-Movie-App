import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:huflix_movie_app/models/trailer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class StatusBarDetail extends StatefulWidget {
  const StatusBarDetail(
      {super.key, required this.idMovie, required this.trailerResult});
  final TrailerResult? trailerResult;
  final int idMovie; // Thêm trường dữ liệu idMovie

  @override
  State<StatusBarDetail> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<StatusBarDetail> {

  bool _trailerFound = false; // Thêm biến boolean để kiểm tra xem có trailer được tìm thấy không
  YoutubePlayerController? _youtubePlayerController;
  late String userId = "Đang tải...";

  late bool _isliked ;
  late bool _isdisliked;

  @override
  void initState() {
    super.initState();
    // getUserInteract();
    initializeInteractions();
    // Gọi phương thức để lấy thông tin trailer và xử lý kết quả
    if (widget.trailerResult != null) {
      setState(() {
        _trailerFound = true;
        _youtubePlayerController = YoutubePlayerController(
          initialVideoId: widget.trailerResult!.key,
          flags: const YoutubePlayerFlags(
            autoPlay: true,
            mute: false,
          ),
        );
      });
    };
  }

  @override
  void dispose() {
    _youtubePlayerController?.dispose();
    super.dispose();
  }

  void showVideoDialog() {
    double scrwidth = MediaQuery.of(context).size.width;
    if (_trailerFound) {
      // Chỉ hiển thị dialog nếu đã tìm thấy trailer
      showModalBottomSheet(
          backgroundColor: Colors.black,
          isScrollControlled: true,
          context: context,
          builder: scrwidth < 700
              ? (BuildContext context) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        YoutubePlayer(
                          controller: _youtubePlayerController!,
                          showVideoProgressIndicator: true,
                          onReady: () {},
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.black, // Màu chữ
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.white), // Viền màu trắng
                              borderRadius:
                                  BorderRadius.circular(8), // Độ cong viền
                            ),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Đóng'),
                        ),
                      ],
                    ),
                  );
                }
              : (BuildContext context) {
                  return SizedBox(
                    height: 500,
                    // color: Colors.black,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          YoutubePlayer(
                            controller: _youtubePlayerController!,
                            showVideoProgressIndicator: true,
                            onReady: () {},
                          ),
                          // ElevatedButton(
                          //   style: ElevatedButton.styleFrom(
                          //     foregroundColor: Colors.white,
                          //     backgroundColor: Colors.black, // Màu chữ
                          //     shape: RoundedRectangleBorder(
                          //       side: const BorderSide(
                          //           color: Colors.white), // Viền màu trắng
                          //       borderRadius:
                          //           BorderRadius.circular(8), // Độ cong viền
                          //     ),
                          //   ),
                          //   onPressed: () => Navigator.pop(context),
                          //   child: const Text('Đóng'),
                          // ),
                        ],
                      ),
                    ),
                  );
                });
    } else {
      // Hiển thị AlertDialog thông báo rằng không có trailer
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          content: Text("Phim này chưa có trailer"),
        ),
      );
    }
  }

  Future<String> getCurrentUserData() async {
    final loginUser = FirebaseAuth.instance.currentUser;
    if (loginUser != null) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(loginUser.uid)
          .get();
      Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
      setState(() {
        userId = userData['uid'];
        print(userId);
      });
      return userId;
    } else {
      return "";
    }
  }

  void initializeInteractions() async {
  _isliked = false; // Khởi tạo giá trị ban đầu cho _isliked
  _isdisliked = false; // Khởi tạo giá trị ban đầu cho _isdisliked
  // Gọi getUserInteract() sau khi _isliked và _isdisliked đã được khởi tạo
  await getUserInteract();
}

  Future<void> getUserInteract() async {
  var userId = await getCurrentUserData();
  var collection = FirebaseFirestore.instance.collection('interact');
  var docSnapshot = await collection.doc("$userId-${widget.idMovie}").get();

  if (docSnapshot.exists) {
    Map<String, dynamic> data = docSnapshot.data()!;
    setState(() {
      _isliked = data['isLiked'] ?? false;
      _isdisliked = data['isDisliked'] ?? false;
    });
  } else {
    await addInteractDetail(
      userId,
      widget.idMovie.toString(),
      false,
      false,
    );
    setState(() {
      _isliked = false;
      _isdisliked = false;
    });
  }
}

  Future<void> addInteractDetail(
    String userId,
    String movieId,
    bool isLiked,
    bool isDisliked,
  ) async {
    // Thêm vào bảng interact
    await FirebaseFirestore.instance.collection("interact").doc("$userId-$movieId").set({
      'userId': userId,
      'movieId': movieId,
      'isLiked': isLiked,
      'isDisliked': isDisliked,
    });
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
                    color: const Color.fromARGB(255, 128, 10, 2),
                  ),
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
                ),
              ),
              // button 3
              Container(
                width: 40,
                height: 40,
                // margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 4,
                    color: const Color.fromARGB(255, 128, 10, 2),
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: _isliked == false
                        ? const Icon(
                            Icons.thumb_up_outlined,
                            size: 20,
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.thumb_up,
                            size: 20,
                            color: Color.fromARGB(255, 152, 17, 17),
                          ),
                    onPressed: () async {
                      var collection = FirebaseFirestore.instance.collection('movies');
                      var docSnapshot = await collection.doc(widget.idMovie.toString()).get();

                      var likeCount = 0;
                      if (docSnapshot.exists) {
                        Map<String, dynamic> data = docSnapshot.data()!;
                        likeCount = data['likeCount'] ?? 0;
                      }

                      setState(() {
                        _isliked = !_isliked;
                        if (_isliked && _isdisliked) {
                          _isdisliked = false;
                        }
                      });


                      await FirebaseFirestore.instance.collection('movies').doc(widget.idMovie.toString()).set({
                        'likeCount': _isliked ? likeCount + 1 : likeCount - 1,
                      }, SetOptions(merge: true));

                       await addInteractDetail(
                        userId,
                        widget.idMovie.toString(),
                        _isliked,
                        _isdisliked,
                      );

                    },
                  ),
                ),
              ),
              // button 4
              Container(
                width: 40,
                height: 40,
                // margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 4,
                    color: const Color.fromARGB(255, 128, 10, 2),
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: _isdisliked == false
                        ? const Icon(
                            Icons.thumb_down_outlined,
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.thumb_down,
                            color: Color.fromARGB(255, 150, 8, 8),
                          ),
                    onPressed: () async {
                      var collection = FirebaseFirestore.instance.collection('movies');
                      var docSnapshot = await collection.doc(widget.idMovie.toString()).get();

                      var dislikeCount = 0;
                      if (docSnapshot.exists) {
                        Map<String, dynamic> data = docSnapshot.data()!;
                        dislikeCount = data['dislikeCount'] ?? 0;
                      }

                      setState(() {
                        _isdisliked = !_isdisliked;
                        if (_isdisliked && _isliked) {
                          _isliked = false;
                        }
                      });

                   

                      await FirebaseFirestore.instance.collection('movies').doc(widget.idMovie.toString()).set({
                      'dislikeCount': _isliked ? dislikeCount + 1 : dislikeCount - 1,
                      }, SetOptions(merge: true));


                      await addInteractDetail(
                        userId,
                        widget.idMovie.toString(),
                        _isliked,
                        _isdisliked,
                      );
                    },
                  ),
                ),
              ),
              Container(
                width: 40,
                height: 40,
                // margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 4,
                    color: const Color.fromARGB(255, 128, 10, 2),
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.download_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      // Xử lý sự kiện khi người dùng nhấn vào nút Tải xuống
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
