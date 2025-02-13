import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/expense_cubit.dart';

Future<void> displayTextInputDialog(BuildContext context) async {
  final TextEditingController textFieldController = TextEditingController();
  final TextEditingController moneyFieldController = TextEditingController();

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog.adaptive(
        title: const Text('Add Task:'),
        content: Column(
          children: [
            TextField(
              maxLines: null,
              minLines: 1,
              controller: textFieldController,
              decoration: const InputDecoration(
                hintText: "Purpose",
              ),
              autofocus: true,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.done,
            ),
            TextField(
              maxLines: null,
              minLines: 1,
              controller: moneyFieldController,
              decoration: const InputDecoration(
                hintText: "Amount",
              ),
              autofocus: true,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.done,
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('CANCEL'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              // Add task and trim whitespace
              BlocProvider.of<ExpenseCubit>(context).addTodo(
                  textFieldController.text.trim(),
                  moneyFieldController.text.trim());

              if (kDebugMode) {
                print(textFieldController.text.trim());
              }
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
