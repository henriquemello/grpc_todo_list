import 'package:protos/protos.dart';
import 'package:server/services/services.dart';

void main(List<String> arguments) async{
  final server = Server.create(
  services: [TodoListService()],
  codecRegistry: CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
);
  await server.serve(port: 50051);
  print('Server listening on port ${server.port} ...');
}
