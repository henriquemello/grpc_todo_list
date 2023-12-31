import 'dart:async';
import 'dart:ui';

import 'package:app/presentation/cubits/todo_cubit.dart';
import 'package:get_it/get_it.dart';

import '../data/datasources/datasources.dart';
import '../data/repositories/repositories.dart';
import '../domain/repositories/repositories.dart';
import '../domain/usecases/usecases.dart';
import '../infra/adapters/adapters.dart';
import '../infra/remote/remotes.dart';

final getIt = GetIt.instance;

StreamController<Locale> localizationStream = StreamController<Locale>();

Future init() async {

  //grpcAdapter
  getIt.registerLazySingleton<GrpcAdapter>(() => GrpcAdapterImpl());

  //datasources
  getIt.registerLazySingleton<TodoRemoteDatasource>(
      () => TodoRemoteDatasourceImpl(grpcClient: getIt.call()));

  //repositories
  getIt.registerLazySingleton<TodoRepository>(
      () => TodoRepositoryImpl(todoRemoteDatasource: getIt.call()));

  //usecases
  getIt.registerFactory(() => GetAllTasksUsecase(repository: getIt.call()));
  getIt.registerFactory(() => CreateTaskUsecase(repository: getIt.call()));
  getIt.registerFactory(() => BroadcastTasksUsecase(repository: getIt.call()));
  getIt.registerFactory(() => UpdateStatusUsecase(repository: getIt.call()));
  getIt.registerFactory(() => DeleteTaskUsecase(repository: getIt.call()));

  //Cubit
  getIt.registerFactory(
    () => TodoCubit(
      getAllTasksUsecase: getIt.call(),
      createTaskUsecase: getIt.call(),
      broadcastTasksUsecase: getIt.call(),
      updateStatusUsecase: getIt.call(),
      deleteTaskUsecase: getIt.call(),
    ),
  );
}
