import 'package:app/data/models/models.dart';
import 'package:app/domain/entities/entities.dart';

class TaskMapper {
  static List<TaskEntity> toEntityList(List<TaskModel> model) => model
      .map(
        (model) => TaskEntity(
          owner: UserEntity(id: model.owner),
          title: model.title,
          done: model.done,
        ),
      )
      .toList();

  static TaskEntity toEntity(TaskModel model) => TaskEntity(
        owner: UserEntity(id: model.owner),
        title: model.title,
        done: model.done,
      );

  static TaskModel toModel(TaskEntity entity) => TaskModel(
        owner: entity.owner.id,
        title: entity.title,
        done: entity.done,
      );
}
