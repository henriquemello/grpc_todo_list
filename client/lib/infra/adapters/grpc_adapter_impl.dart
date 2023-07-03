import 'dart:async';

import 'package:app/data/models/task_model.dart';
import 'package:app/infra/adapters/grpc/grpc_adapter.dart';
import 'package:protos/protos.dart';

import '../../domain/exceptions/exceptions.dart';

class GrpcAdapterImpl implements GrpcAdapter {
  late ClientChannel _channel;
  late TodoListServiceClient _service;

  GrpcAdapterImpl() {
    _channel = ClientChannel(
      '10.0.2.2',
      port: 50051,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    _service = TodoListServiceClient(_channel);
  }

  @override
  Future<Tasks> listAll({required String id}) async {
    try {
      final user = User()..id = id;
      //await Future.delayed(const Duration(seconds: 1)); //TODO: simulate delay
      final tasks = await _service.listAll(user);
      return tasks;
    } on Exception catch (e, s) {
      throw AdapterException(
        exception: e,
        stackTrace: s,
        reason: "Error calling listAll from GrpcAdapter",
      );
    }
  }

  @override
  Future<Task> addTask({required TaskModel task}) async {
    try {
      final taskProto = Task()
        ..title = task.title
        ..owner = task.owner
        ..done = task.done;

      //await Future.delayed(const Duration(seconds: 1)); //TODO: simulate delay
      final taskAdded = await _service.addTask(taskProto);
      return taskAdded;
    } on Exception catch (e, s) {
      throw AdapterException(
        exception: e,
        stackTrace: s,
        reason: "Error calling addTask from GrpcAdapter",
      );
    }
  }
 
  @override
  Stream<Tasks> get taskStream => _service.broadcast(User()..id = "");
}
