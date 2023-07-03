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
      final listTasks = TaskMapper.toEntityList(resultListModel);
      return listTasks;
    } on Exception catch (e, s) {
      throw RepositoryException(
          exception: e,
          stackTrace: s,
          reason: 'Error calling getTasks from TodoRepository');
    }
  }

  @override
  Future<TaskEntity> addTask(TaskEntity task) async {
    final taskModel = TaskMapper.toModel(task);
    final resultTaskModel = await todoRemoteDatasource.addTask(task: taskModel);

    try {
      final task = TaskMapper.toEntity(resultTaskModel);
      return task;
    } on Exception catch (e, s) {
      throw RepositoryException(
          exception: e,
          stackTrace: s,
          reason: 'Error calling addTask from TodoRepository');
    }
  }

  @override
  Stream<List<TaskEntity>> get taskStrem =>
      TaskMapper.toEntityListStream(todoRemoteDatasource.taskStream);

  @override
  Future updateStatus(TaskEntity task) async {
    try {
      final taskModel = TaskMapper.toModel(task);
      await todoRemoteDatasource.updateStatus(task: taskModel);
    } on Exception catch (e, s) {
      throw RepositoryException(
          exception: e,
          stackTrace: s,
          reason: 'Error calling updateStatus from TodoRepository');
    }
  }
  
  @override
  Future deleteTask(TaskEntity task) async {
    try {
      final taskModel = TaskMapper.toModel(task);
      await todoRemoteDatasource.deleteTask(task: taskModel);
    } on Exception catch (e, s) {
      throw RepositoryException(
          exception: e,
          stackTrace: s,
          reason: 'Error calling deleteTask from TodoRepository');
    }
  }
}
