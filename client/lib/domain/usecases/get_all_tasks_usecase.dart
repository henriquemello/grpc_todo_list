import 'package:app/domain/entities/entities.dart';
import 'package:app/domain/repositories/repositories.dart';

class GetAllTasksUsecase{
  final TodoRepository repository;

  GetAllTasksUsecase({required this.repository});
  
  Future<List<TaskEntity>> call({required UserEntity user})async {
    final listTasks = await repository.getTasks(user);
    return listTasks;
  }
}