import 'package:app/data/datasources/datasources.dart';
import 'package:app/data/models/task_model.dart';
import 'package:app/infra/adapters/grpc/grpc_adapter.dart';

class TodoRemoteDatasourceImpl implements TodoRemoteDatasource {
  final GrpcAdapter grcpClient;

  TodoRemoteDatasourceImpl({
    required this.grcpClient,
  });

  @override
  Future<List<TaskModel>> getTasks({required String id}) async {
    
    final tasksProto = await grcpClient.listAll(id: id);

    final model = tasksProto.task
        .map(
          (taskProto) => TaskModel.fromProto(
            title: taskProto.title,
            owner: taskProto.owner,
            done: taskProto.done,
          ),
        )
        .toList();

    return model;
  }
}