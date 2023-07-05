import 'package:app/domain/entities/entities.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../config/configs.dart';

class CustomImputDialog extends StatefulWidget {
  const CustomImputDialog({
    super.key,
    required this.callback,
  });

  final Function(TaskEntity) callback;

  @override
  State<CustomImputDialog> createState() => _CustomImputDialogState();
}

class _CustomImputDialogState extends State<CustomImputDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _textEditingController = TextEditingController();

  Future<void> show(BuildContext context) async {
    final l10n = TodoAppLocalizations.of(context)!;
     _textEditingController.clear();
    return await showDialog(
      context: context,
      builder: (context) {
        bool isChecked = false;
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            content: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _textEditingController,
                      validator: (value) {
                        return value!.isNotEmpty
                            ? null
                            : l10n.taskNameIsRequired;
                      },
                      decoration:
                          InputDecoration(hintText: l10n.taskName),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(l10n.isItCompleted),
                        Checkbox(
                            value: isChecked,
                            onChanged: (checked) {
                              setState(() {
                                isChecked = checked!;
                              });
                            })
                      ],
                    )
                  ],
                )),
            title: Text(l10n.newTask),
            actions: <Widget>[
              TextButton(
                child: Text(l10n.createIt),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {

                    final newTask = TaskEntity(
                      id: const Uuid().v4(),
                      title: _textEditingController.text,
                      done: isChecked,
                      owner: const UserEntity(id:  AppConstants.USER_NAME),
                    );

                    widget.callback(newTask);
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = TodoAppLocalizations.of(context)!;
    return FloatingActionButton(
      onPressed: () async {
        await show(context);
      },
      tooltip: l10n.addNewTask,
      child: const Icon(Icons.add),
    );
  }
}
