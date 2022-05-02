import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import '../controller/dashboard_controller.dart';
import '../controller/feed_controller.dart';
import '../controller/login_controller.dart';
import '../controller/splash_screen_controller.dart';



class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashScreenController>(() => SplashScreenController());
    Get.lazyPut<FeedController>(() => FeedController());
    Get.lazyPut<DashboardController>(() => DashboardController(),tag:'mainTag');
    Get.lazyPut<LoginController>(() => LoginController());
    // Get.lazyPut<ListTypeFeedsDetailController>(() => ListTypeFeedsDetailController());
  }
}