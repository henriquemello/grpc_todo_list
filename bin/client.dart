// ignore_for_file: avoid_print

import 'package:grpc/grpc.dart';

import '../protos/generated/helloworld.pbgrpc.dart';
import '../protos/generated/todolist.pbgrpc.dart';


Future<void> main(List<String> args) async {
  final channel = ClientChannel(
    'localhost',
    port: 50051,
    options: ChannelOptions(
      credentials: const ChannelCredentials.insecure(),
      codecRegistry:
          CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
    ),
  );
  final stub = TodoListServiceClient(channel);

  //final name = args.isNotEmpty ? args[0] : 'Mello!';
  const idOwner = 'Mello';

  try {
    final response = await stub.listAll(
      User()..id = idOwner,
      options: CallOptions(compression: const GzipCodec()),
    );
    
    print(response.task);
  } catch (e) {
    print('Caught error: $e');
  }
  await channel.shutdown();
}
