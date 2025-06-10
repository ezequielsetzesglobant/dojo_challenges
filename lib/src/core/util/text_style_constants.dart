import 'package:flutter/material.dart';

import 'color_constants.dart';
import 'number_constants.dart';

abstract class TextStyleConstants {
  static const TextStyle movieCardTitleTextStyle = TextStyle(
    fontSize: NumberConstants.movieCardTitleTextStyleFontSize,
    color: Colors.black,
  );

  static const TextStyle unsuccessMessageTextStyle = TextStyle(
    fontSize: NumberConstants.unsuccessMessageTextStyleFontSize,
    color: ColorConstants.appThemeColor,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle defaultPageMessageTextStyle = TextStyle(
    fontSize: NumberConstants.defaultPageTextStyleFontSize,
    color: Colors.redAccent,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle generalTextStyle = TextStyle(
    fontSize: NumberConstants.generalTextStyleFontSize,
    color: Colors.black45,
  );
}
