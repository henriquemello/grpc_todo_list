import 'package:app/domain/entities/entities.dart';
import 'package:app/presentation/cubits/todo_cubit.dart';
import 'package:app/presentation/cubits/todo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/configs.dart';
import '../widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TodoCubit todoCubit;

  @override
  void initState() {
    super.initState();
    todoCubit = BlocProvider.of<TodoCubit>(context);
    todoCubit.broadcastTasks(id: AppConstants.USER_NAME).listen((event) {
      _getTasks();
    });
    _getTasks();
  }

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
      body: BlocConsumer<TodoCubit, TodoState>(
        builder: (context, state) {
          if (state is TodoInitial) {
            return const Center(
              child: Text("Hello ${AppConstants.USER_NAME}, press the button to manage your tasks"),
            );
          } else if (state is TodoLoading ||
              state is TodoAdded ||
              state is TodoStatusChanged ||
              state is TodoDeleted) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TodoSuccess) {
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];

                return ListTile(
                  leading: Checkbox(
                    value: task.done,
                    onChanged: (checked) => _changeStatus(task),
                  ),
                  title: Text(
                    task.title,
                    style: task.done
                        ? const TextStyle(
                            decoration: TextDecoration.lineThrough)
                        : null,
                  ),
                  subtitle: Text(
                    "id: ${task.id.substring(0, 7)}",
                    style: const TextStyle(fontSize: 11),
                  ),
                  trailing: GestureDetector(
                    onTap: () async => _showConfirmationDialog(context, task),
                    child: const Icon(Icons.delete),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text("Something went wrong: ${state.toString()}"),
            );
          }
        },
        listener: (context, state) {
          if (state is TodoAdded) {
            _showSnackSuccess(context, state.task);
          }
        },
      ),
      floatingActionButton: CustomImputDialog(
        callback: _createTask,
      ),
    );
  }

  void _showSnackSuccess(BuildContext context, TaskEntity task) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Task '${task.title}' was created!"),
      ),
    );
  }

  Future<void> _showConfirmationDialog(context, task) {
    return CustomConfirmationDialog(
      task: task,
      callback: (task) => _deleteTask(task),
    ).show(context);
  }

  void _getTasks() => todoCubit.getTasksFromUser(id: AppConstants.USER_NAME);

  void _createTask(TaskEntity task) => todoCubit.createTask(task: task);

  void _changeStatus(TaskEntity task) => todoCubit.changeStatus(task: task);

  void _deleteTask(TaskEntity task) => todoCubit.deleteTask(task: task);
}
