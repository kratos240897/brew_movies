// ignore_for_file: avoid_print
import 'package:brew_movies/helpers/end_points.dart';
import 'package:get/get.dart';
import '../models/now_playing_response.dart';
import '../models/top_rated_response.dart';
import '../service/api_service.dart';

abstract class AppRepo {
  Future<List<Results>> getNowPlaying();
  Future<List<TopRatedResults>> getTopRated();
  void init();
}

class AppRepository extends AppRepo {
  final ApiService _apiService = Get.put(ApiService());
  @override
  void init() {
    _apiService.addInterceptor();
  }

  @override
  Future<List<Results>> getNowPlaying() async {
    try {
      final res = await _apiService.getRequest(EndPoints.nowPlaying, {
      });
      final movies = NowPlayingResponse.fromJson(res.data).results;
      return movies;
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

   @override
  Future<List<TopRatedResults>> getTopRated() async {
    try {
      final res = await _apiService.getRequest(EndPoints.topRated, {
      });
      final movies = TopRatedResponse.fromJson(res.data).results;
      return movies;
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }
}
