import 'package:flutter/material.dart';
import 'package:huflix_movie_app/models/staff.dart';
import 'package:huflix_movie_app/views/drawer/movie_drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  List<Staff> listMember = [
    Staff(id: "20DH111098", name: "Nguyễn Anh Thành",img: "assets/member/thanh.jpg", position: "Developer" ),
    Staff(id: "20DH111947", name: "Nguyễn Anh Duy",img: "assets/member/duy.jpg", position: "Developer" ),
    Staff(id: "20DH111195", name: "Đặng Duy Thông",img: "assets/member/duythong.jpg", position: "Developer" ),
    Staff(id: "20DH111890", name: "Đinh Hoàng Minh Thuận",img: "assets/member/thuan.jpg", position: "Developer" ),
    Staff(id: "20DH111918", name: "Nguyễn Hồng Ân",img: "assets/member/an.jpg", position: "Developer" ),
  ];
  @override
  Widget build(BuildContext context) {
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
        iconTheme: IconThemeData(
          color: Colors.white,
          size: 32
          
        ),
        centerTitle: true,
      ),
      // drawer: const MyDrawer(),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 100,),
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
            Expanded(
              child: TabBarView(
                children: [
                  CarouselSlider(
                    options:  CarouselOptions(
                    autoPlay: true,
                    height: 500,
                    disableCenter: false,
                    enlargeCenterPage: true,
                    viewportFraction: 0.8,),
                  
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
                              child: Image.asset(member.img!, fit: BoxFit.cover, height: 320, width: 400,),
                            ), 
                            const SizedBox(height: 12,),
                            Text(member.name!,style: TextStyle(color: Colors.white, fontSize: 18),),
                            Text(member.id!,style: TextStyle(color: Colors.white, fontSize: 18),),
                            Text(member.position!,style: TextStyle(color: Colors.white, fontSize: 18),),

                          ],
                        ),
                      
                      ),
                    );
                   }).toList(),
                  ),
                  Column(
                    // Add your Column content here
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
