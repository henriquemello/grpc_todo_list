import 'package:app/domain/entities/entities.dart';

class TaskEntity {
  final UserEntity owner;
  final String title;
  final bool done;

  TaskEntity({
    required this.owner,
    required this.title,
    required this.done,
  });
}
