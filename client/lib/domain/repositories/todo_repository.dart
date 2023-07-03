import 'package:app/domain/entities/entities.dart';

abstract class TodoRepository {
  Future<List<TaskEntity>> getTasks(UserEntity user);
  Future<TaskEntity> addTask(TaskEntity task);
  Stream<List<TaskEntity>> get taskStrem;
  Future updateStatus(TaskEntity task);
  Future deleteTask(TaskEntity task);
}
