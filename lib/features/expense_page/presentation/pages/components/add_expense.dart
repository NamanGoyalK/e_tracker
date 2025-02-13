import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/expense_m.dart';
import '../../cubit/expense_cubit.dart';

Future<Expense?> displayTextInputDialog(BuildContext context) async {
  final TextEditingController textFieldController = TextEditingController();
  final TextEditingController moneyFieldController = TextEditingController();

  return showDialog<Expense>(
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
              final expense = Expense(
                name: textFieldController.text.trim(),
                createdAt: DateTime.now(),
                price: moneyFieldController.text.trim(),
              );
              BlocProvider.of<ExpenseCubit>(context).addExpense(expense);
              Navigator.pop(context, expense);
            },
          ),
        ],
      );
    },
  );
}
