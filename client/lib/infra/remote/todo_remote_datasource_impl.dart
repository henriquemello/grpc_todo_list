import 'package:app/data/datasources/datasources.dart';
import 'package:app/data/models/task_model.dart';
import 'package:app/infra/adapters/grpc/grpc_adapter.dart';

import '../../domain/exceptions/exceptions.dart';

class TodoRemoteDatasourceImpl implements TodoRemoteDatasource {
  final GrpcAdapter grpcClient;

  TodoRemoteDatasourceImpl({
    required this.grpcClient,
  });

  @override
  Future<List<TaskModel>> getTasks({required String id}) async {
    final tasksProto = await grpcClient.listAll(id: id);
    try {
      final model = tasksProto.task
          .map(
            (taskProto) => TaskModel.fromProto(
              id: taskProto.id,
              title: taskProto.title,
              owner: taskProto.owner,
              done: taskProto.done,
            ),
          )
          .toList();

      return model;
    } on Exception catch (e, s) {
      throw DatasourceException(
        exception: e,
        stackTrace: s,
        reason: "Error calling getTasks from TodoRemoteDatasource",
      );
    }
  }

  @override
  Future<TaskModel> addTask({required TaskModel task}) async {
    final taskProto = await grpcClient.addTask(task: task);
    try {
      final model = TaskModel.fromProto(
        id: taskProto.id,
        title: taskProto.title,
        owner: taskProto.owner,
        done: taskProto.done,
      );

      return model;
    } on Exception catch (e, s) {
      throw DatasourceException(
        exception: e,
        stackTrace: s,
        reason: "Error calling addTask from TodoRemoteDatasource",
      );
    }
  }

  @override
  Stream<List<TaskModel>> get taskStream {
    return grpcClient.taskStream.map<List<TaskModel>>(
      (asyncTaskProto) => asyncTaskProto.task
          .map<TaskModel>(
            (taskProto) => TaskModel.fromProto(
              id: taskProto.id,
              title: taskProto.title,
              owner: taskProto.owner,
              done: taskProto.done,
            ),
          )
          .toList(),
    );
  }

  @override
  Future updateStatus({required TaskModel task}) async {
    await grpcClient.updateStatus(task: task);
  }

  @override
  Future deleteTask({required TaskModel task}) async {
    await grpcClient.removeTask(task: task);
  }
}
