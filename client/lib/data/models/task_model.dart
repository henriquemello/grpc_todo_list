class TaskModel {
  final String id;
  final String title;
  final String owner;
  final bool done;

  TaskModel({
    required this.id,
    required this.title,
    required this.owner,
    required this.done,
  });

  factory TaskModel.fromProto({
    required String id,
    required String title,
    required String owner,
    required bool done,
  }) {
    return TaskModel(
      id: id,
      title: title,
      owner: owner,
      done: done,
    );
  }
}
