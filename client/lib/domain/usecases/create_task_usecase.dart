import 'package:app/domain/entities/entities.dart';

import '../repositories/repositories.dart';

class CreateTaskUsecase {
  final TodoRepository repository;

  CreateTaskUsecase({required this.repository});

  Future<TaskEntity> call(TaskEntity task) async {
    final taskAdded = await repository.addTask(task);
    return taskAdded;
  }
}
