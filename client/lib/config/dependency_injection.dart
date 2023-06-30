
import 'package:app/presentation/cubits/todo_cubit.dart';
import 'package:get_it/get_it.dart';

import '../data/datasources/datasources.dart';
import '../data/repositories/repositories.dart';
import '../domain/repositories/repositories.dart';
import '../domain/usecases/usecases.dart';
import '../infra/adapters/adapters.dart';
import '../infra/remote/remotes.dart';

final getIt = GetIt.instance;

Future init() async{

  //grpcAdapter
  getIt.registerLazySingleton<GrpcAdapter>(() => GrpcAdapterImpl());

  //datasources
  getIt.registerLazySingleton<TodoRemoteDatasource>(() => TodoRemoteDatasourceImpl(grcpClient: getIt.call()));

  //repositories
  getIt.registerLazySingleton<TodoRepository>(() => TodoRepositoryImpl(todoRemoteDatasource: getIt.call()));

  //usecases
  getIt.registerFactory(() => GetAllTasksUsecase(repository: getIt.call()));

  //Cubit
  getIt.registerFactory(() => TodoCubit(getAllTasksUsecase: getIt.call()));

}