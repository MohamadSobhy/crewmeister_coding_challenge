import 'package:get_it/get_it.dart';

import 'core/errors/repository_call_handler.dart';
import 'core/network/network_info.dart';
import 'features/absences/data/datasources/absences_remote_data_source.dart';
import 'features/absences/data/repositories/app_absences_repository.dart';
import 'features/absences/domain/repositories/absences_repository.dart';
import 'features/absences/domain/usecases/get_list_of_absences.dart';
import 'features/absences/presentation/absences_bloc/absences_bloc.dart';
import 'features/absences/presentation/controllers/absences_filters_controller.dart';

final servLocator = GetIt.instance;

Future<void> initServiceLocator() async {
  /// Register your services here
  // serviceLocator.registerLazySingleton<YourService>(() => YourService());

  //! Core
  servLocator.registerLazySingleton(
    () => RepositoryCallHandler(networkInfo: servLocator()),
  );
  servLocator.registerLazySingleton<NetworkInfo>(() => AppNetworkInfo());

  //! Features

  //* Absences List Feature
  //? Absences Blocs & Controllers
  servLocator.registerLazySingleton(
    () => AbsencesBloc(getListOfAbsences: servLocator()),
  );

  servLocator.registerLazySingleton(() => AbsencesFiltersController());

  //? Absences Usecases
  servLocator.registerLazySingleton(
    () => GetListOfAbsences(repository: servLocator()),
  );

  //? Absences Repositories
  servLocator.registerLazySingleton<AbsencesRepository>(
    () => AppAbsencesRepository(
      remoteDataSource: servLocator(),
      callHandler: servLocator(),
    ),
  );

  //? Absences Data Sources
  servLocator.registerLazySingleton<AbsencesRemoteDataSource>(
    () => AppAbsencesRemoteDataSource(),
  );
}
