// ignore_for_file: avoid_print

import 'package:brew_movies/helpers/utils.dart';
import 'package:brew_movies/models/top_rated_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';

import '../../models/now_playing_response.dart';
import '../../repo/app_repo.dart';

class HomeController extends GetxController {
  final AppRepository _appRepo = Get.find<AppRepository>();
  final List<Results> nowPlaying = [];
  final List<TopRatedResults> topRated = [];
  final tempNowPlaying = RxList.empty();
  final tempTopRated = RxList.empty();
  final error = ''.obs;
  final _utils = Utils();

  @override
  void onInit() {
    _appRepo.init();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      getNowPlaying();
    });
    super.onInit();
  }

  void filter(int currentIndex, String query) {
    if (currentIndex == 0) {
      if (query.isNotEmpty) {
        tempNowPlaying.clear();
        for (var movie in nowPlaying) {
          tempNowPlaying.addIf(
              movie.title.toLowerCase().contains(query.toLowerCase()), movie);
        }
      } else {
        tempNowPlaying.clear();
        tempNowPlaying.addAll(nowPlaying);
      }
    } else if (currentIndex == 1) {
      if (query.isNotEmpty) {
        tempTopRated.clear();
        for (var movie in topRated) {
          tempTopRated.addIf(
              movie.title.toLowerCase().contains(query.toLowerCase()), movie);
        }
      } else {
        tempTopRated.clear();
        tempTopRated.addAll(topRated);
      }
    }
  }

  void getNowPlaying() async {
    _utils.showLoading();
    _appRepo.getNowPlaying().then((value) {
      _utils.hideLoading();
      nowPlaying.clear();
      nowPlaying.addAll(value);
      tempNowPlaying.clear();
      tempNowPlaying.addAll(value);
    }).onError((error, stackTrace) {
      _utils.hideLoading();
      print(error);
      this.error.value = error.toString();
    });
  }

  void getTopRated() async {
    _utils.showLoading();
    _appRepo.getTopRated().then((value) {
      _utils.hideLoading();
      topRated.clear();
      topRated.addAll(value);
      tempTopRated.clear();
      tempTopRated.addAll(value);
    }).onError((error, stackTrace) {
      _utils.hideLoading();
      print(error);
      this.error.value = error.toString();
    });
  }
}
