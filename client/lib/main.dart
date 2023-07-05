import 'package:app/presentation/cubits/todo_cubit.dart';
import 'package:app/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/config/dependency_injection.dart' as di;

import 'config/configs.dart';

void main() async {
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  initState() {
    super.initState();
    localizationStream.stream.listen((event) => setState((){locale = event;}));
  }

  Locale locale = const Locale('en', 'US');
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
        home: const HomePage(),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: TodoAppLocalizations.localizationsDelegates,
        supportedLocales: TodoAppLocalizations.supportedLocales,
        locale: locale,
      ),
    );
  }
}
