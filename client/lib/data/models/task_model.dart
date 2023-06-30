class TaskModel {
  final String owner;
  final String title;
  final bool done;

  TaskModel({
    required this.owner,
    required this.title,
    required this.done,
  });

  factory TaskModel.fromProto({
    required String title,
    required String owner,
    required bool done,
  }) {
    return TaskModel(
      title: title,
      owner: owner,
      done: done,
    );
  }
}
