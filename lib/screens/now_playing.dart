import 'package:brew_movies/helpers/constants.dart';
import 'package:brew_movies/models/now_playing_response.dart';
import 'package:brew_movies/routes/router.dart';
import 'package:brew_movies/screens/home/home_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class NowPlaying extends GetView<HomeController> {
  const NowPlaying({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        itemCount: controller.tempNowPlaying.length,
        itemBuilder: (_, index) {
          final movie = controller.tempNowPlaying[index] as Results;
          return InkWell(
            onTap: (() => Get.toNamed(AppRouter.MOVIE_DETAIL,
                arguments: {'index': 0, 'movie': movie})),
            child: Container(
              height: 200.0,
              margin: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl:
                              Constants.BASE_IMAGE_URL + movie.posterPath),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            movie.title,
                            style: GoogleFonts.actor(
                                fontWeight: FontWeight.bold, fontSize: 22.0),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            movie.overview,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.raleway(fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
