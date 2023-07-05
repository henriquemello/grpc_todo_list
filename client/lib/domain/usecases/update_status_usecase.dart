import 'package:app/domain/entities/entities.dart';
import 'package:app/domain/repositories/repositories.dart';

class UpdateStatusUsecase {
  final TodoRepository repository;

  UpdateStatusUsecase({required this.repository});

  Future call({required TaskEntity task}) async {
    await repository.updateStatus(task);
  }
}
