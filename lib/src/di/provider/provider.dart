import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

import '../../core/resource/data_state.dart';
import '../../core/util/string_constants.dart';
import '../../data/data_source/local/data_base/auth_data_base.dart';
import '../../data/data_source/local/data_base/backup_data_base.dart';
import '../../data/data_source/local/data_base/data_base.dart';
import '../../data/data_source/remote/api_service/api_service.dart';
import '../../data/repository/popularity_repository.dart';
import '../../data/repository/repository.dart';
import '../../domain/api_service/api_service_interface.dart';
import '../../domain/data_base/auth_data_base_interface.dart';
import '../../domain/data_base/data_base_interface.dart';
import '../../domain/entity/movie_entity.dart';
import '../../domain/entity/movie_list_entity.dart';
import '../../domain/repository/repository_interface.dart';
import '../../domain/use_case/implementation/use_case.dart';
import '../../domain/use_case/use_case_interface.dart';
import '../../presentation/auth_controller/auth_controller.dart';

final movieProvider = FutureProvider.family<DataState<MovieListEntity>, bool>((
  ref,
  isOriginalRepository,
) async {
  final useCaseProviderVariable = await ref.watch(
    useCaseProvider(isOriginalRepository).future,
  );
  return await useCaseProviderVariable();
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
  final clientProviderVariable = ref.watch(clientProvider);
  return ApiService(client: clientProviderVariable);
});

final clientProvider = Provider<Client>((ref) {
  return Client();
});

final dataBaseProvider = FutureProvider<DataBaseInterface>((ref) async {
  final dataBaseProviderVariable = ref.watch(dataBaseInstanceProvider);
  await dataBaseProviderVariable.openDataBase();
  ref.onDispose(() async {
    try {
      await dataBaseProviderVariable.closeDataBase();
    } catch (exception) {
      debugPrint(
        '${StringConstants.providerDataBaseErrorMessage}${exception.toString()}',
      );
    }
  });
  return dataBaseProviderVariable;
});

final dataBaseInstanceProvider = Provider<DataBaseInterface>((ref) {
  return DataBase.instance;
});

final authStateChangesProvider = StreamProvider<User?>((ref) {
  final authDataBaseProviderVariable = ref.watch(authDataBaseProvider);
  return authDataBaseProviderVariable.authStateChanges;
});

final authControllerProvider = Provider<AuthController>((ref) {
  final authDataBaseProviderVariable = ref.watch(authDataBaseProvider);
  return AuthController(authDataBase: authDataBaseProviderVariable);
});

final authDataBaseProvider = Provider<AuthDataBaseInterface>((ref) {
  return AuthDataBase.instance;
});

final makeABackupProvider = FutureProvider<void>((ref) async {
  final dataBaseInstanceProviderVariable = ref.watch(dataBaseInstanceProvider);
  final backupDataBaseProviderVariable = ref.watch(backupDataBaseProvider);
  final movies = await dataBaseInstanceProviderVariable.movieDao.getMovies();
  await backupDataBaseProviderVariable.dropBackup();
  await backupDataBaseProviderVariable.makeABackup(movies);
});

final getBackupContentProvider = FutureProvider<List<MovieEntity>>((ref) async {
  final backupDataBaseProviderVariable = ref.watch(backupDataBaseProvider);
  return await backupDataBaseProviderVariable.getBackupContent();
});

final backupDataBaseProvider = Provider<BackupDataBase>((ref) {
  return BackupDataBase.instance;
});
