import '../models/models.dart';

abstract class TodoRemoteDatasource{
  Future<List<TaskModel>> getTasks({required String id});
  Future<TaskModel> addTask({required TaskModel task});
  Stream<List<TaskModel>> get taskStream;
  Future updateStatus({required TaskModel task});
  Future deleteTask({required TaskModel task});
}