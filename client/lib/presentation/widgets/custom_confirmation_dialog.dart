import 'package:app/domain/entities/entities.dart';
import 'package:flutter/material.dart';

import '../../config/configs.dart';


class CustomConfirmationDialog {
  final TaskEntity task;
  final Function(TaskEntity) callback;

  CustomConfirmationDialog({required this.task, required this.callback});

  Future<void> show(BuildContext context) async {
    final l10n = TodoAppLocalizations.of(context)!;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(l10n.deleteTask),
          content: Text(
            l10n.doYoutWant(task.title),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text(l10n.noAnswer),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text(l10n.yesAnswer),
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
