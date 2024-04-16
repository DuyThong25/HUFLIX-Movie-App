import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:huflix_movie_app/models/staff.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  List<Staff> listMember = [
    Staff(
        id: "20DH111098",
        name: "Nguyễn Anh Thành",
        img: "assets/member/thanh.jpg",
        position: "Developer"),
    Staff(
        id: "20DH111947",
        name: "Nguyễn Anh Duy",
        img: "assets/member/duy.jpg",
        position: "Developer"),
    Staff(
        id: "20DH111195",
        name: "Đặng Duy Thông",
        img: "assets/member/duythong.jpg",
        position: "Developer"),
    Staff(
        id: "20DH111890",
        name: "Đinh Hoàng Minh Thuận",
        img: "assets/member/thuan.jpg",
        position: "Developer"),
    Staff(
        id: "20DH111918",
        name: "Nguyễn Hồng Ân",
        img: "assets/member/an.jpg",
        position: "Developer"),
  ];
  @override
  Widget build(BuildContext context) {
    double scrwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Về chúng tôi",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Color.fromARGB(255, 255, 255, 255))),
        iconTheme: IconThemeData(color: Colors.white, size: 32),
        centerTitle: true,
      ),
      // drawer: const MyDrawer(),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            scrwidth < 700
            ? const SizedBox(
              height: 100,
            ): const SizedBox(
              height: 50),
            // Title of Tab
            Container(
              height: 80,
              color: Colors.black,
              child: const TabBar(
                // Custom tab tilte
                dividerColor: Colors.transparent,
                indicatorColor: Colors.purple,
                labelColor: Colors.purple,
                indicatorSize: TabBarIndicatorSize.label,
                unselectedLabelColor: Colors.grey,
                unselectedLabelStyle:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                labelStyle:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                padding: EdgeInsets.only(left: 30, right: 30),
                indicatorWeight: 4,
                // Data title
                tabs: [
                  Tab(text: "Thành viên"),
                  Tab(text: "Đề tài"),
                ],
              ),
            ),
            // Content of Tab
            scrwidth < 700
            ? Expanded(
              child: TabBarView(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      height: 500,
                      disableCenter: false,
                      enlargeCenterPage: true,
                      viewportFraction: 0.8,
                    ),
                    items: listMember.map((member) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.transparent,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(26),
                                child: Image.asset(
                                  member.img!,
                                  fit: BoxFit.cover,
                                  height: 320,
                                  width: 400,
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                member.name!,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                member.id!,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                member.position!,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const Column(
                    // Add your Column content here
                    children: [
                      Text("TÊN ỨNG DỤNG",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      SizedBox(
                        height: 20,
                      ),
                      Text("HUFLIX",
                          style: TextStyle(
                              color: Color.fromARGB(255, 215, 0, 0),
                              fontSize: 30,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 20,
                      ),
                      Text("MỤC TIÊU",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Xây dựng một cộng đồng đánh giá phim đa dạng và phong phú.",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              "Tạo nên một nền tảng cho người dùng để chia sẻ ý kiến, bình luận và đánh giá về phim ảnh.",
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            textAlign: TextAlign.center,),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              "Cung cấp thông tin chi tiết và đánh giá chất lượng về các bộ phim từ cộng đồng người dùng.",
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            textAlign: TextAlign.center,),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )
            //giao diện ngang
            : Expanded(
              child: TabBarView(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      height: 500,
                      disableCenter: false,
                      enlargeCenterPage: true,
                      viewportFraction: 0.35,
                    ),
                    items: listMember.map((member) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.transparent,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(26),
                                child: Image.asset(
                                  member.img!,
                                  fit: BoxFit.cover,
                                  height: 150,
                                  width: 200,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                member.name!,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                member.id!,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                member.position!,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const Column(
                    // Add your Column content here
                    children: [
                      Text("TÊN ỨNG DỤNG",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      SizedBox(
                        height: 5,
                      ),
                      Text("HUFLIX",
                          style: TextStyle(
                              color: Color.fromARGB(255, 215, 0, 0),
                              fontSize: 30,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 5,
                      ),
                      Text("MỤC TIÊU",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      SizedBox(
                        height: 5,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Xây dựng một cộng đồng đánh giá phim đa dạng và phong phú.",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              "Tạo nên một nền tảng cho người dùng để chia sẻ ý kiến, bình luận và đánh giá về phim ảnh.",
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            textAlign: TextAlign.center,),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              "Cung cấp thông tin chi tiết và đánh giá chất lượng về các bộ phim từ cộng đồng người dùng.",
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            textAlign: TextAlign.center,),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
