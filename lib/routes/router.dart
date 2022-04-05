// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../screens/home/home.dart';
import '../screens/home/home_binding.dart';
import '../screens/movie_detail/movie_detail.dart';
import '../screens/movie_detail/movie_detail_binding.dart';

class AppRouter {
  static const HOME = '/';
  static const MOVIE_DETAIL = '/movie-detail';
  Route? generateRoutes(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case HOME:
        return GetPageRoute(
            routeName: HOME, page: () => const Home(), binding: HomeBinding());
      case MOVIE_DETAIL:
        final arguments = args as Map<String, dynamic>;
        return GetPageRoute(
            routeName: MOVIE_DETAIL,
            page: () =>
                MovieDetail(index: arguments['index'] as int, movie: arguments['movie']),
            transition: Transition.cupertino,
            binding: MovieDetailBinding());
    }
    return null;
  }
}
