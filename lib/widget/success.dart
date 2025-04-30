import 'package:flutter/material.dart';

import '../model/movie.dart';
import '../util/api_service_constants.dart';
import '../util/number_constants.dart';
import '../util/string_constants.dart';
import 'movie_card.dart';
import 'movie_scaffold.dart';

class Success extends StatelessWidget {
  const Success({super.key, required this.movies, required this.callback});

  final List<Movie> movies;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return MovieScaffold(
      title: StringConstants.homePageTitle,
      callBack: callback,
      child: GridView.builder(
        itemCount: movies.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: NumberConstants.homePageCrossAxisCount,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GridTile(
            child: MovieCard(
              title: movies[index].title,
              image:
                  '${ApiServiceConstants.imageNetwork}${movies[index].posterPath}',
            ),
          );
        },
      ),
    );
  }
}
