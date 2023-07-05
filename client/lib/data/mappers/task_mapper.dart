import 'package:app/data/models/models.dart';
import 'package:app/domain/entities/entities.dart';

class TaskMapper {
  static List<TaskEntity> toEntityList(List<TaskModel> model) => model
      .map(
        (model) => TaskEntity(
          id: model.id,
          title: model.title,
          owner: UserEntity(id: model.owner),
          done: model.done,
        ),
      )
      .toList();

  static TaskEntity toEntity(TaskModel model) => TaskEntity(
        id: model.id,
        title: model.title,
        owner: UserEntity(id: model.owner),
        done: model.done,
      );

  static TaskModel toModel(TaskEntity entity) => TaskModel(
        id: entity.id,
        title: entity.title,
        owner: entity.owner.id,
        done: entity.done,
      );

  static Stream<List<TaskEntity>> toEntityListStream(
      Stream<List<TaskModel>> model) {
    return model.asyncMap(
      (event) => event
          .map(
            (model) => TaskEntity(
              id: model.id,
              title: model.title,
              owner: UserEntity(id: model.owner),
              done: model.done,
            ),
          )
          .toList(),
    );
  }
}
