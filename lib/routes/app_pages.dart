import 'package:get/get.dart';
import '../controller/feed_detail_controller.dart';
import '../ui/dash_board_page.dart';
import '../ui/feed/feed_detail_page.dart';
import '../ui/feed_page.dart';
import '../ui/login_page.dart';
import '../ui/splash_screen_page.dart';
import 'app_routes.dart';
import 'dashboard_binding.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.Splash,
      page: () => SplashScreenPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.DASHBOARD,
      page: () => DashboardPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.FeedPage,
      page: ()=> FeedPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
        name: AppRoutes.ListTypeFeedDetailPage,
        page: () => ListTypeFeedsDetail(),
        binding: ListTypeFeedsDetailBinding(),
        transition: Transition.native,
        preventDuplicates : false
    ),
    GetPage(
      name: AppRoutes.Login,
      page: ()=> LoginPage(),
      binding: DashboardBinding(),
    ),
  ];
}