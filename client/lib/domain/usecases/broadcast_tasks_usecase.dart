import 'package:app/domain/entities/entities.dart';
import 'package:app/domain/repositories/repositories.dart';

class BroadcastTasksUsecase {
  final TodoRepository repository;

  BroadcastTasksUsecase({required this.repository});

  Stream<List<TaskEntity>> get taskStream => repository.taskStrem;
}
