import 'package:brew_movies/models/top_rated_response.dart';
import 'package:brew_movies/screens/home/home_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helpers/constants.dart';
import '../routes/router.dart';

class TopRated extends GetView<HomeController> {
  const TopRated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        itemCount: controller.tempTopRated.length,
        itemBuilder: (_, index) {
          final movie = controller.tempTopRated[index] as TopRatedResults;
          return InkWell(
            onTap: (() => Get.toNamed(AppRouter.MOVIE_DETAIL,
                arguments: {'index': 1, 'movie': movie})),
            child: Dismissible(
              direction: DismissDirection.endToStart,
              key: Key(UniqueKey().toString()),
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              onDismissed: (_) async {
                controller.topRated.remove(movie);
                controller.tempTopRated.remove(movie);
              },
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
            ),
          );
        },
      );
    });
  }
}
