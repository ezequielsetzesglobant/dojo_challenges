import 'package:flutter/material.dart';

import '../../core/util/route_constants.dart';
import '../../presentation/view/auth_page.dart';
import '../../presentation/view/default_page.dart';
import '../../presentation/view/home_page.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstants.homeRoute:
        return MaterialPageRoute(builder: (_) => HomePage());
      case RouteConstants.authRoute:
        return MaterialPageRoute(builder: (_) => AuthPage());
      default:
        return MaterialPageRoute(builder: (_) => const DefaultPage());
    }
  }
}
