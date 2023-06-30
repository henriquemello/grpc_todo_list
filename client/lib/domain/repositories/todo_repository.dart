import 'package:app/domain/entities/entities.dart';

abstract class TodoRepository{
  Future<List<TaskEntity>> getTasks(UserEntity user);
}