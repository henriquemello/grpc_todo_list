import 'package:flutter/material.dart';
import 'package:protos/protos.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'XXX Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ClientChannel _channel;
  late TodoListServiceClient _service;
  Tasks? tasks;

  @override
  void initState() {
    super.initState();
    _channel = ClientChannel(
      '10.0.2.2',
      port: 50051,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );

    _service = TodoListServiceClient(_channel);
  }

  void _getTasks() async {
    final user = User()..id = '112233';

    final tasks = await _service.listAll(user);
    setState(() {
      this.tasks = tasks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (tasks != null)
              Text(tasks!.task.first.title)
            else
              const Text("Empty")
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getTasks,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
