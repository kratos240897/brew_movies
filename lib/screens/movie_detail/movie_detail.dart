import 'package:brew_movies/helpers/constants.dart';
import 'package:brew_movies/models/now_playing_response.dart';
import 'package:brew_movies/models/top_rated_response.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MovieDetail extends StatelessWidget {
  final int index;
  final dynamic movie;
  final mediaQuery = Get.mediaQuery;
  MovieDetail({Key? key, required this.index, required this.movie})
      : super(key: key);

  Results typeConvert(dynamic movie) {
    if (index == 0) {
      return movie as Results;
    } else {
      final topRatedMovie = movie as TopRatedResults;
      final result = Results(
          adult: topRatedMovie.adult,
          backdropPath: topRatedMovie.backdropPath,
          genreIds: topRatedMovie.genreIds,
          id: topRatedMovie.id,
          originalLanguage: topRatedMovie.originalLanguage,
          originalTitle: topRatedMovie.originalTitle,
          overview: topRatedMovie.overview,
          popularity: topRatedMovie.popularity,
          posterPath: topRatedMovie.posterPath,
          releaseDate: topRatedMovie.releaseDate,
          title: topRatedMovie.title,
          video: topRatedMovie.video,
          voteAverage: topRatedMovie.voteAverage,
          voteCount: topRatedMovie.voteCount);
      return result;
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedMovie = typeConvert(movie);
    final dateTimeObj = DateTime.parse(selectedMovie.releaseDate);
    final formattedDate = DateFormat.yMMMEd().format(dateTimeObj);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.back,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
              child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl:
                      Constants.BASE_IMAGE_URL + selectedMovie.backdropPath)),
          Positioned(
              width: mediaQuery.size.width * 0.85,
              height: mediaQuery.size.height * 0.45,
              bottom: 0,
              child: Container(
                color: Colors.black54,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedMovie.title,
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        formattedDate,
                        style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 12.0),
                      Text(
                        selectedMovie.overview,
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.lato(
                            wordSpacing: 1.2,
                            height: 1.5,
                            fontSize: 16.0,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
