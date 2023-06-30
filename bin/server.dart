// ignore_for_file: avoid_print

import 'package:grpc/grpc.dart';


import '../protos/generated/todolist.pbgrpc.dart';

final Tasks _tasks = Tasks();

class TodoListService extends TodoListServiceBase {
 
  @override
  Future<Tasks> listAll(ServiceCall call, User request) {
      
      _tasks.task.add(Task()
        ..owner='mello'
        ..id=1222
        ..done=false
        ..title="fazer tarefa x"
      );
      return Future.value(_tasks);
  }
 
}

Future<void> main(List<String> args) async {
  final server = Server.create(
    services: [TodoListService()],
    codecRegistry: CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
  );
  await server.serve(port: 50051);
  print('Server listening on port ${server.port}...');
}
