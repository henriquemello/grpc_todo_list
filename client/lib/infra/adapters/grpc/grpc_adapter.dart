import 'package:protos/protos.dart';

abstract class GrpcAdapter{
  Future<Tasks> listAll({required String id});
}