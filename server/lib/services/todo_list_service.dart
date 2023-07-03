import 'dart:async';

import 'package:protos/protos.dart';

class TodoListService extends TodoListServiceBase {
  final Tasks _tasks = Tasks();
  static StreamController<Tasks> taskStreamController =
      StreamController<Tasks>.broadcast();

  TodoListService() {
    _tasks.task.add(Task()
      ..owner = "mello"
      ..id = "1e5f80fc-0679-464c-ab8e-ebb84858add0"
      ..done = false
      ..title = "Task #1");

    _tasks.task.add(Task()
      ..owner = "mello"
      ..id = "32858648-84a8-4497-8a36-e33578e44a27"
      ..done = true
      ..title = "Task #2");

    _tasks.task.add(Task()
      ..owner = "mello"
      ..id = "ec384153-7e80-43cf-9fab-c786b6cd0171"
      ..done = false
      ..title = "Task #3");

    _tasks.task.add(Task()
      ..owner = "mello"
      ..id = "d7a525e3-de71-4dc1-93fd-da41666905a6"
      ..done = true
      ..title = "Task #4");
  }

  @override
  Future<Tasks> listAll(ServiceCall call, User request) async {
    print('uhullll!!');

    return _tasks;
  }

  @override
  Future<Task> addTask(ServiceCall call, Task request) async {
    print('added uhullll!!');

    _tasks.task.add(request);
    taskStreamController.add(_tasks);
    return request;
  }

  @override
  Stream<Tasks> broadcast(ServiceCall call, User request) =>
      taskStreamController.stream;
}
