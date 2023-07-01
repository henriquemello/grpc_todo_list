import 'package:app/domain/entities/entities.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({
    super.key,
    required this.callback,
  });

  final Function(TaskEntity) callback;

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _textEditingController = TextEditingController();

  Future<void> showInformationDialog(BuildContext context) async {
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
                        const Text("Completed"),
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
        await showInformationDialog(context);
      },
      tooltip: 'Add new Task',
      child: const Icon(Icons.add),
    );
  }
}
