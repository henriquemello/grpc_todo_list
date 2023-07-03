import 'package:app/domain/entities/entities.dart';
import 'package:flutter/material.dart';

class CustomConfirmationDialog {
  final TaskEntity task;
  final Function(TaskEntity) callback;

  CustomConfirmationDialog({required this.task, required this.callback});

  Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete task'),
          content: Text(
            "Do you want to remove '${task.title}' ?",
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Yes, please!'),
              onPressed: () {
                callback(task);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
