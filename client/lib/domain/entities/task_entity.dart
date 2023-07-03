import 'package:app/domain/entities/entities.dart';

class TaskEntity {
  final String id;
  final String title;
  final UserEntity owner;
  final bool done;

  TaskEntity({
    required this.id,
    required this.title,
    required this.owner,
    required this.done,
  });
}
