import 'package:flutter/material.dart';

import '../../core/util/asset_constants.dart';
import '../../core/util/color_constants.dart';
import '../../core/util/number_constants.dart';
import 'movie_scaffold.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MovieScaffold(
      backgroundColor: ColorConstants.splashScreenColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AssetConstants.splashScreen,
            width: NumberConstants.imageSize,
            height: NumberConstants.imageSize,
          ),
          const SizedBox(height: NumberConstants.sizedBoxHeight),
          const Center(
            child: CircularProgressIndicator(
              color: ColorConstants.appThemeColor,
            ),
          ),
        ],
      ),
    );
  }
}
