import 'package:app/domain/entities/entities.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

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
                            : "Task name is required";
                      },
                      decoration:
                          const InputDecoration(hintText: "type task title .."),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Completed?"),
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
            title: const Text('New task'),
            actions: <Widget>[
              InkWell(
                child: const Text('Create'),
                onTap: () {
                  if (_formKey.currentState!.validate()) {

                    final newTask = TaskEntity(
                      id: const Uuid().v4(),
                      title: _textEditingController.text,
                      done: isChecked,
                      owner: UserEntity(id: "mello"),
                    );

                    widget.callback(newTask);
                    _textEditingController.clear();
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
    return FloatingActionButton(
      onPressed: () async {
        await show(context);
      },
      tooltip: 'Add new Task',
      child: const Icon(Icons.add),
    );
  }
}
