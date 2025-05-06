import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/resource/data_state.dart';
import '../../core/util/string_constants.dart';
import '../../data/data_source/local/data_base/data_base.dart';
import '../../data/data_source/remote/api_service/api_service.dart';
import '../../data/repository/popularity_repository.dart';
import '../../data/repository/repository.dart';
import '../../domain/api_service/api_service_interface.dart';
import '../../domain/data_base/data_base_interface.dart';
import '../../domain/entity/movie_list_entity.dart';
import '../../domain/repository/repository_interface.dart';
import '../../domain/use_case/implementation/use_case.dart';
import '../../domain/use_case/use_case_interface.dart';

final movieProvider = FutureProvider.family<DataState<MovieListEntity>, bool>((
  ref,
  isOriginalRepository,
) async {
  final useCaseVariable = await ref.watch(
    useCaseProvider(isOriginalRepository).future,
  );
  return await useCaseVariable();
});

final useCaseProvider = FutureProvider.family<UseCaseInterface, bool>((
  ref,
  isOriginalRepository,
) async {
  final RepositoryInterface repositoryProviderVariable;
  if (isOriginalRepository) {
    repositoryProviderVariable = await ref.watch(repositoryProvider.future);
  } else {
    repositoryProviderVariable = await ref.watch(
      popularityRepositoryProvider.future,
    );
  }
  return UseCase(repository: repositoryProviderVariable);
});

final repositoryProvider = FutureProvider<RepositoryInterface>((ref) async {
  final apiServiceProviderVariable = ref.watch(apiServiceProvider);
  final dataBaseProviderVariable = await ref.watch(dataBaseProvider.future);
  return Repository(
    apiService: apiServiceProviderVariable,
    movieDao: dataBaseProviderVariable.movieDao,
  );
});

final popularityRepositoryProvider = FutureProvider<RepositoryInterface>((
  ref,
) async {
  final apiServiceProviderVariable = ref.watch(apiServiceProvider);
  final dataBaseProviderVariable = await ref.watch(dataBaseProvider.future);
  return PopularityRepository(
    apiService: apiServiceProviderVariable,
    movieDao: dataBaseProviderVariable.movieDao,
  );
});

final apiServiceProvider = Provider<ApiServiceInterface>((ref) {
  return ApiService();
});

final dataBaseProvider = FutureProvider<DataBaseInterface>((ref) async {
  final dataBase = DataBase.instance;
  await dataBase.openDataBase();
  ref.onDispose(() async {
    try {
      await dataBase.closeDataBase();
    } catch (exception) {
      debugPrint('${StringConstants.errorMessage}: ${exception.toString()}');
    }
  });
  return dataBase;
});
