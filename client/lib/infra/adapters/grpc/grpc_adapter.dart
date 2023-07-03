import 'package:protos/protos.dart';

import '../../../data/models/models.dart';

abstract class GrpcAdapter{
  Future<Tasks> listAll({required String id});
  Future<Task> addTask({required TaskModel task});
  Stream<Tasks>  get taskStream;
}