import 'package:flutter/material.dart';

import 'color_constants.dart';
import 'number_constants.dart';

abstract class TextStyleConstants {
  static const TextStyle homePageUnsuccessMessageTextStyle = TextStyle(
    fontSize: NumberConstants.homePageUnsuccessMessageTextStyleFontSize,
    color: ColorConstants.appThemeColor,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle movieCardTitleTextStyle = TextStyle(
    fontSize: NumberConstants.movieCardTitleTextStyleFontSize,
    color: Colors.black,
  );

  static const TextStyle defaultPageMessageTextStyle = TextStyle(
    fontSize: NumberConstants.defaultPageTextStyleFontSize,
    color: Colors.redAccent,
    fontWeight: FontWeight.bold,
  );
}
