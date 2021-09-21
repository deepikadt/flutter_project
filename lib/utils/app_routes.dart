import 'package:flutter/material.dart';
import 'package:product_hunt_app/providers/controllers/home_provider.dart';
import 'package:product_hunt_app/providers/controllers/post_detail_provider.dart';
import 'package:product_hunt_app/providers/controllers/search_provider.dart';
import 'package:product_hunt_app/ui/home_screen.dart';
import 'package:product_hunt_app/ui/product_detail.dart';
import 'package:product_hunt_app/ui/search_products.dart';
import 'package:product_hunt_app/ui/splash.dart';
import 'package:provider/provider.dart';

abstract class AppRoutes {
  static const String splash = '/splash';
  static const String home = '/home_route';
  static const String searchProducts = '/search_products';
  static const String postDetail = '/post_detail';
}

class AppRouteSetting {
  Route<dynamic> Function(RouteSettings) onGenerateRoute({Widget tabItem}) =>
      (settings) {
        Widget target;
        dynamic argument = settings.arguments;
        switch (settings.name) {
          case AppRoutes.splash:
            target = Splash();
            break;
          case AppRoutes.postDetail:
            target = ChangeNotifierProvider<PostDetailProvider>(
              create: (context) => PostDetailProvider(argument),
              child: PostDetail(
                postModel: argument,
              ),
            );
            break;
          case AppRoutes.searchProducts:
            target = target = ChangeNotifierProvider<SearchProvider>(
                create: (context) => SearchProvider(), child: SearchProducts());
            break;
          case AppRoutes.home:
            target = target = ChangeNotifierProvider<HomeProvider>(
                create: (context) => HomeProvider(), child: HomeScreen());
            break;
          default:
            target = Splash();
        }
        return MaterialPageRoute(
          builder: (context) => target,
        );
      };
}
