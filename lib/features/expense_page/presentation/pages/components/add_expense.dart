import 'package:e_tracker/common/widgets/index.dart';
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
        title: const Text('A D D  E X P E N S E:'),
        content: SizedBox(
          height: 120,
          child: Column(
            children: [
              TextFromUser(
                controller: textFieldController,
                hintText: "Enter Purpose",
                keyboardType: TextInputType.phone,
                labelText: 'Purpose',
                obscureText: false,
                icon: Icons.abc,
              ),
              SizedBox(
                height: 15,
              ),
              TextFromUser(
                controller: moneyFieldController,
                hintText: "Enter Amount",
                keyboardType: TextInputType.text,
                labelText: 'Amount',
                obscureText: false,
                icon: Icons.abc,
              ),
            ],
          ),
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
