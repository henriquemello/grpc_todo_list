# grpc_todo_list
A simple way how to synchronize TODO List between devices using gRPC communication


## How to generate the proto files:

    dart pub global activate protoc_plugin

    export PATH="$PATH:$HOME/.pub-cache/bin"
    
    protoc --dart_out=grpc:protos/generated -Iprotos protos/helloworld.proto 
## Running the Server
 
    dart bin/server.dart 


## Compiling the protofile

To compile the `.proto` files you need to have the `protoc` compiler installed, I choose v3.20.1 (download it from [here](https://github.com/protocolbuffers/protobuf/releases/tag/v3.20.1)) then run `npm run compile` in the root directory

ps. there is an issue on lastest version for nodeJs [issue#127](https://github.com/protocolbuffers/protobuf-javascript/issues/127)
