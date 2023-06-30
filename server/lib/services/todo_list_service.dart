import 'package:protos/protos.dart';

class TodoListService extends TodoListServiceBase {
  final Tasks _tasks = Tasks();

  List<Tasks> tasksInMemory =[];
  
  TodoListService(){
       _tasks.task.add(Task()
      ..owner = 'mello'
      ..id = 1
      ..done = false
      ..title = "Task #1");

       _tasks.task.add(Task()
      ..owner = 'mello'
      ..id = 2
      ..done = true
      ..title = "Task #2");

       _tasks.task.add(Task()
      ..owner = 'mello'
      ..id = 3
      ..done = false
      ..title = "Task #3");

       _tasks.task.add(Task()
      ..owner = 'mello'
      ..id = 4
      ..done = true
      ..title = "Task #4");
  }

  @override
  Future<Tasks> listAll(ServiceCall call, User request) async {
      
    print('uhullll!!');

    return _tasks;
  }
}
