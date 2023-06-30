import 'package:protos/protos.dart';

class TodoListService extends TodoListServiceBase {
  final Tasks _tasks = Tasks();

  @override
  Future<Tasks> listAll(ServiceCall call, User request) async {
    
    print('uhullll!!');
    _tasks.task.add(Task()
      ..owner = request.id
      ..id = 1222
      ..done = false
      ..title = "fazer tarefa x");

    return _tasks;
  }
}
