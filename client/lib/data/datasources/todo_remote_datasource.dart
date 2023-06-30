import '../models/models.dart';

abstract class TodoRemoteDatasource{
  Future<List<TaskModel>> getTasks({required String id});
}