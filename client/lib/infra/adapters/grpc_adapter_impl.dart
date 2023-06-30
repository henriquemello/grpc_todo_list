import 'package:app/infra/adapters/grpc/grpc_adapter.dart';
import 'package:protos/protos.dart';

class GrpcAdapterImpl implements GrpcAdapter{

  late ClientChannel _channel;
  late TodoListServiceClient _service;

  GrpcAdapterImpl(){
      _channel = ClientChannel(
      '10.0.2.2',
      port: 50051,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    _service = TodoListServiceClient(_channel);
  }

  @override
  Future<Tasks> listAll({required String id}) async {
    final user = User()..id = id;
    await Future.delayed(const Duration(seconds: 1)); //TODO: simulate delay
    final tasks = await _service.listAll(user);
    return tasks; 
  }
}