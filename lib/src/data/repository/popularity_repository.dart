import '../../core/resource/data_state.dart';
import '../../core/util/number_constants.dart';
import '../../domain/entity/movie_list_entity.dart';
import 'repository.dart';

class PopularityRepository extends Repository {
  PopularityRepository({required super.apiService, required super.movieDao});

  @override
  Future<DataState<MovieListEntity>> getMovieList() async {
    DataState<MovieListEntity> movieListDataState = await super.getMovieList();
    if (movieListDataState.type == DataStateType.success) {
      return DataSuccess(
        movieListDataState.data!.copyWith(
          results:
              movieListDataState.data!
                  .where(
                    (movie) =>
                        movie.popularity >=
                        NumberConstants.popularityRepositoryCondition,
                  )
                  .toList(),
        ),
      );
    } else {
      return movieListDataState;
    }
  }
}
