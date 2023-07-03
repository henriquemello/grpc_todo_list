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

  TaskEntity copyWith({
    String? id,
    String? title,
    UserEntity? owner,
    bool? done,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      owner: owner ?? this.owner,
      done: done ?? this.done,
    );
  }
}
