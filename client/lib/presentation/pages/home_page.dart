import 'package:app/domain/entities/entities.dart';
import 'package:app/presentation/cubits/todo_cubit.dart';
import 'package:app/presentation/cubits/todo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/configs.dart';
import '../widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
    final l10n = TodoAppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(l10n.welcome(AppConstants.USER_NAME)),
        actions: [
          LanguageButton(onPressed: _changeLanguage),
        ],
      ),
      body: BlocConsumer<TodoCubit, TodoState>(
        builder: (context, state) {
          if (state is TodoInitial) {
            return Center(
              child: Text(l10n.initialLoad(AppConstants.USER_NAME)),
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(l10n.errorMessage(state.toString()),
                    textAlign: TextAlign.center),
              ),
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
    final l10n = TodoAppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.taskTitleWasCreated(task.title)),
      ),
    );
  }

  Future<void> _showConfirmationDialog(context, task) async {
    return CustomConfirmationDialog(
      task: task,
      callback: (task) => _deleteTask(task),
    ).show(context);
  }

  void _getTasks() => todoCubit.getTasksFromUser(id: AppConstants.USER_NAME);

  void _createTask(TaskEntity task) => todoCubit.createTask(task: task);

  void _changeStatus(TaskEntity task) => todoCubit.changeStatus(task: task);

  void _deleteTask(TaskEntity task) => todoCubit.deleteTask(task: task);

  void _changeLanguage() {
    const usLocale = Locale('en', 'US');
    const frLocale = Locale('fr', 'CA');

    final currentLocale = Localizations.localeOf(context);
    localizationStream.add(
      currentLocale.languageCode == usLocale.languageCode ? frLocale : usLocale,
    );
  }
}
