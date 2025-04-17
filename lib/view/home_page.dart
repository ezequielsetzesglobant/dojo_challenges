import 'package:dojo_challenges/repository/repository.dart';
import 'package:dojo_challenges/util/color_constants.dart';
import 'package:dojo_challenges/widget/movie_scaffold.dart';
import 'package:dojo_challenges/widget/splash_screen.dart';
import 'package:dojo_challenges/widget/success.dart';
import 'package:flutter/material.dart';

import '../model/movie_list.dart';
import '../resource/data_state.dart';
import '../util/asset_constants.dart';
import '../util/string_constants.dart';
import '../widget/unsuccess.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.repository});

  final Repository repository;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DataState<MovieList>>(
      future: repository.getMovieList(),
      builder: (context, AsyncSnapshot<DataState<MovieList>> snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data!.type) {
            case DataStateType.success:
              return MovieScaffold(
                title: StringConstants.homePageTitle,
                child: Success(movies: snapshot.data!.data!.results),
              );
            case DataStateType.empty:
              return MovieScaffold(
                title: StringConstants.homePageTitle,
                child: Unsuccess(
                  text: StringConstants.homePageEmptyMessage,
                  image: AssetConstants.homePageEmptyImage,
                ),
              );
            case DataStateType.error:
              return MovieScaffold(
                title: StringConstants.homePageTitle,
                child: Unsuccess(
                  text: snapshot.data!.error!,
                  image: AssetConstants.homePageErrorImage,
                ),
              );
          }
        }
        return MovieScaffold(
          backgroundColor: ColorConstants.splashScreenColor,
          child: SplashScreen(),
        );
      },
    );
  }
}
