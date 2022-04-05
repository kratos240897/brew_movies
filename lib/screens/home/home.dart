import 'package:brew_movies/screens/home/home_controller.dart';
import 'package:brew_movies/screens/now_playing.dart';
import 'package:brew_movies/screens/top_rated.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeController controller = Get.find();
  int currentIndex = 0;
  final TextEditingController searchController = TextEditingController();
  final pages = const [NowPlaying(), TopRated()];

  @override
  void initState() {
    searchController.addListener(() {
      controller.filter(currentIndex, searchController.text.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Search',
                    prefixIconColor: Colors.black,
                    hintStyle: GoogleFonts.openSans(
                        fontSize: 16.0, color: Colors.black),
                    border: InputBorder.none),
              ),
            ),
          ),
        ),
      ),
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      backgroundColor: Colors.amber,
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            indicatorColor: Colors.transparent,
            labelTextStyle: MaterialStateProperty.all(GoogleFonts.openSans(
                fontSize: 14.0, fontWeight: FontWeight.bold))),
        child: NavigationBar(
            selectedIndex: currentIndex,
            backgroundColor: Colors.amber,
            height: 60.0,
            onDestinationSelected: (value) async {
              setState(() {
                currentIndex = value;
              });
              if (currentIndex == 0) {
                if (controller.nowPlaying.isEmpty) {
                  controller.getNowPlaying();
                }
              } else if (currentIndex == 1) {
                if (controller.topRated.isEmpty) {
                  controller.getTopRated();
                }
              }
            },
            destinations: const [
              NavigationDestination(
                  selectedIcon: Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 5.0),
                    child: Icon(
                      Icons.movie_rounded,
                      size: 30.0,
                      color: Colors.black,
                    ),
                  ),
                  icon: Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 5.0),
                    child: Icon(
                      Icons.movie_outlined,
                      size: 28.0,
                      color: Colors.black45,
                    ),
                  ),
                  label: 'Now Playing'),
              NavigationDestination(
                  selectedIcon: Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 5.0),
                    child: Icon(
                      Icons.star_outlined,
                      size: 30.0,
                      color: Colors.black,
                    ),
                  ),
                  icon: Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 5.0),
                    child: Icon(
                      Icons.star_border_outlined,
                      size: 28.0,
                      color: Colors.black45,
                    ),
                  ),
                  label: 'Top Rated'),
            ]),
      ),
    );
  }
}
