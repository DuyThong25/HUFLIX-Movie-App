import 'package:flutter/material.dart';
import 'package:huflix_movie_app/views/drawer/movie_drawer.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("About Us",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Color.fromARGB(255, 255, 255, 255))),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              color: Colors.white,
              iconSize: 36,
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        centerTitle: true,
      ),
      drawer: const MyDrawer(),
      body: Expanded(
          child: Column(
        children: [
          DefaultTabController(
            length: 2,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 100,),
                const Text("Gioi thieu app", 
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                ),),
                // Title of Tab
                Container(
                  height: 100,
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
                      Tab(text: "Member"),
                      Tab(text: "Contact"),
                    ],
                  ),
                ),
                // const Member(),
              ],
            ),
          )
        ],
      )),
    );
  }
}
