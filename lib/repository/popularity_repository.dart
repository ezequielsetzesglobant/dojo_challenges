import '../model/movie_list.dart';
import '../resource/data_state.dart';
import '../util/number_constants.dart';
import 'repository.dart';

class PopularityRepository extends Repository {
  PopularityRepository({required super.apiService, required super.dataBase});

  @override
  Future<DataState<MovieList>> getMovieList() async {
    DataState<MovieList> movieListDataState = await super.getMovieList();
    if (movieListDataState.type == DataStateType.success) {
      return DataSuccess(
        MovieList(
          page: movieListDataState.data!.page,
          results:
              movieListDataState.data!.results
                  .where(
                    (movie) =>
                        movie.popularity >=
                        NumberConstants.popularityRepositoryCondition,
                  )
                  .toList(),
          totalResults: movieListDataState.data!.totalResults,
          totalPages: movieListDataState.data!.totalPages,
        ),
      );
    } else {
      return movieListDataState;
    }
  }
}
