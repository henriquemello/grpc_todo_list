import 'package:app/data/datasources/datasources.dart';
import 'package:app/domain/entities/task_entity.dart';
import 'package:app/domain/entities/user_entity.dart';
import 'package:app/domain/repositories/repositories.dart';

import '../../domain/exceptions/exceptions.dart';
import '../mappers/mappers.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDatasource todoRemoteDatasource;

  TodoRepositoryImpl({
    required this.todoRemoteDatasource,
  });

  @override
  Future<List<TaskEntity>> getTasks(UserEntity user) async {
    
    final resultListModel = await todoRemoteDatasource.getTasks(id: user.id);
    
    try {
      final listTasks = TaskMapper.toEntity(resultListModel);
      return listTasks;
    } on Exception catch (e, s) {

      throw RepositoryException(
          exception: e,
          stackTrace: s,
          reason: 'Error calling getTasks from TodoRepository');
    }
  }
}
