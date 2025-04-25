import 'package:flutter/material.dart';

import '../data_source/local/data_base/data_base.dart';
import '../data_source/remote/api_service/api_service.dart';
import '../model/movie_list.dart';
import '../repository/popularity_repository.dart';
import '../repository/repository_interface.dart';
import '../resource/data_state.dart';
import '../util/asset_constants.dart';
import '../util/color_constants.dart';
import '../util/string_constants.dart';
import '../widget/movie_scaffold.dart';
import '../widget/splash_screen.dart';
import '../widget/success.dart';
import '../widget/unsuccess.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.repository});

  final RepositoryInterface repository;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late RepositoryInterface repository;

  @override
  void initState() {
    super.initState();
    repository = widget.repository;
  }

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
                callBack: () {
                  setState(() {
                    repository = PopularityRepository(
                      apiService: ApiService(),
                      dataBase: DataBase.instance,
                    );
                  });
                },
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
