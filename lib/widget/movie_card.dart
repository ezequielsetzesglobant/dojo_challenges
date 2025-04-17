import 'package:cached_network_image/cached_network_image.dart';
import 'package:dojo_challenges/util/number_constants.dart';
import 'package:dojo_challenges/util/text_style_constants.dart';
import 'package:flutter/material.dart';

import '../util/asset_constants.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.title, required this.image});

  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(NumberConstants.movieCardPadding),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.amberAccent,
            width: NumberConstants.movieCardBorderWidth,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(NumberConstants.movieCardPadding),
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(NumberConstants.movieCardBorderRadius),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    placeholder:
                        (context, url) => Image.asset(
                          AssetConstants.movieCardPlaceholderImage,
                          width:
                              NumberConstants.movieCardCachedNetworkImageSize,
                          height:
                              NumberConstants.movieCardCachedNetworkImageSize,
                        ),
                    errorWidget:
                        (context, url, error) => Image.asset(
                          AssetConstants.movieCardPlaceholderImage,
                          width:
                              NumberConstants.movieCardCachedNetworkImageSize,
                          height:
                              NumberConstants.movieCardCachedNetworkImageSize,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: NumberConstants.movieCardSizedBox),
              Text(
                title,
                style: TextStyleConstants.movieCardTitleTextStyle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
