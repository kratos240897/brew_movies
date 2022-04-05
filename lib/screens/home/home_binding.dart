import 'package:brew_movies/repo/app_repo.dart';
import 'package:brew_movies/screens/home/home_controller.dart';
import 'package:get/instance_manager.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => AppRepository());
  }
}
