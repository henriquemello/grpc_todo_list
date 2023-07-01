import 'package:app/domain/entities/entities.dart';

import '../repositories/repositories.dart';

class CreateTaskUsecase {
  final TodoRepository repository;

  CreateTaskUsecase({required this.repository});

  Future call(TaskEntity task) async {}
}
