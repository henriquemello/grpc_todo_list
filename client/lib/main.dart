import 'package:app/presentation/cubits/todo_cubit.dart';
import 'package:app/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/config/dependency_injection.dart' as di;

void main() async {
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.getIt<TodoCubit>()),
      ],
      child: MaterialApp(
        title: 'Todo App gRPC',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreenAccent),
          useMaterial3: true,
        ),
        home: const HomePage(title: 'PokerLab Todo App'),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
