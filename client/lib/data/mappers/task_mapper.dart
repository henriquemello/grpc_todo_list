import 'package:app/data/models/models.dart';
import 'package:app/domain/entities/entities.dart';

class TaskMapper {
  static List<TaskEntity> toEntity(List<TaskModel> model) => model
      .map(
        (model) => TaskEntity(
          owner: UserEntity(id: model.owner),
          title: model.title,
          done: model.done,
        ),
      )
      .toList();
}
