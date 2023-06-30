//
//  Generated code. Do not modify.
//  source: todolist.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'todolist.pb.dart' as $0;

export 'todolist.pb.dart';

@$pb.GrpcServiceName('todolist.TodoListService')
class TodoListServiceClient extends $grpc.Client {
  static final _$listAll = $grpc.ClientMethod<$0.User, $0.Tasks>(
      '/todolist.TodoListService/listAll',
      ($0.User value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Tasks.fromBuffer(value));

  TodoListServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.Tasks> listAll($0.User request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listAll, request, options: options);
  }
}

@$pb.GrpcServiceName('todolist.TodoListService')
abstract class TodoListServiceBase extends $grpc.Service {
  $core.String get $name => 'todolist.TodoListService';

  TodoListServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.User, $0.Tasks>(
        'listAll',
        listAll_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.User.fromBuffer(value),
        ($0.Tasks value) => value.writeToBuffer()));
  }

  $async.Future<$0.Tasks> listAll_Pre($grpc.ServiceCall call, $async.Future<$0.User> request) async {
    return listAll(call, await request);
  }

  $async.Future<$0.Tasks> listAll($grpc.ServiceCall call, $0.User request);
}
