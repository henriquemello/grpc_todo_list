import 'package:app/domain/entities/entities.dart';
import 'package:app/presentation/cubits/todo_cubit.dart';
import 'package:app/presentation/cubits/todo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/custom_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          actions: [
            GestureDetector(
              onTap: _getTasks,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Icon(Icons.refresh),
              ),
            ),
          ],
        ),
        body: BlocBuilder<TodoCubit, TodoState>(
          builder: (context, state) {
            if (state is TodoInitial) {
              return const Center(
                child:
                   Text("Hello Peter, press the button to get your tasks"),
              );
            } else if (state is TodoLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TodoSuccess) {
              return ListView.builder(
                itemCount: state.tasks.length,
                itemBuilder: (context, index) {
                  final task = state.tasks[index];

                  return ListTile(
                    title: Text(task.title),
                    subtitle: Text(task.owner.id),
                    trailing:
                        Checkbox(value: task.done, onChanged: (checked) {}),
                  );
                },
              );
            } else {
              return Center(
                child: Text("Something went wrong:${state.toString()}"),
              );
            }
          },
        ),
        floatingActionButton: const CustomDialog());
  }

  void _getTasks() =>
      BlocProvider.of<TodoCubit>(context).getTasksFromUser(id: "mello");

 
}
