import 'dart:async';

import 'package:app/data/models/task_model.dart';
import 'package:app/infra/adapters/grpc/grpc_adapter.dart';
import 'package:protos/protos.dart';

import '../../config/configs.dart';
import '../../domain/exceptions/exceptions.dart';

class GrpcAdapterImpl implements GrpcAdapter {
  late ClientChannel _channel;
  late TodoListServiceClient _service;

  GrpcAdapterImpl() {
    _channel = ClientChannel(
      AppConstants.SERVER_HOST,
      port: AppConstants.SERVER_PORT,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    _service = TodoListServiceClient(_channel);
  }

  @override
  Future<Tasks> listAll({required String id}) async {
    try {
      final user = User()..id = id;
      await Future.delayed(
          const Duration(milliseconds: 500)); //simulate delay
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
        ..id = task.id
        ..title = task.title
        ..owner = task.owner
        ..done = task.done;

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
  Stream<Tasks> get taskStream => _service.broadcast(User()..id =  AppConstants.USER_NAME);

  @override
  Future updateStatus({required TaskModel task}) async {
    try {
      final taskProto = Task()
        ..id = task.id
        ..title = task.title
        ..owner = task.owner
        ..done = task.done;

      await _service.updateTask(taskProto);
    } on Exception catch (e, s) {
      throw AdapterException(
        exception: e,
        stackTrace: s,
        reason: "Error calling updateStatus from GrpcAdapter",
      );
    }
  }

  @override
  Future removeTask({required TaskModel task}) async {
    try {
      final taskProto = Task()
        ..id = task.id
        ..title = task.title
        ..owner = task.owner
        ..done = task.done;

      await _service.removeTask(taskProto);
    } on Exception catch (e, s) {
      throw AdapterException(
        exception: e,
        stackTrace: s,
        reason: "Error calling removeTask from GrpcAdapter",
      );
    }
  }
}
