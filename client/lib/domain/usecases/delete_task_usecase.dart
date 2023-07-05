import '../entities/entities.dart';
import '../repositories/repositories.dart';

class DeleteTaskUsecase {
  final TodoRepository repository;

  DeleteTaskUsecase({required this.repository});

  Future call({required TaskEntity task}) async {
    await repository.deleteTask(task);
  }
}
