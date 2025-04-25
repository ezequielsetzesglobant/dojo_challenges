import 'package:flutter/material.dart';

import 'route/app_routes.dart';
import 'util/color_constants.dart';
import 'util/route_constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: ColorConstants.appThemeColor,
          centerTitle: true,
        ),
      ),
      initialRoute: RouteConstants.homeRoute,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
