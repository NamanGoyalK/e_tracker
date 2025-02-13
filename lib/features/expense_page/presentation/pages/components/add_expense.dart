import 'package:e_tracker/common/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/expense_m.dart';
import '../../cubit/expense_cubit.dart';

Future<Expense?> displayTextInputDialog(BuildContext context) async {
  final TextEditingController textFieldController = TextEditingController();
  final TextEditingController moneyFieldController = TextEditingController();
  String selectedCategory = 'Food'; // Default category

  return showDialog<Expense>(
    context: context,
    builder: (context) {
      return AlertDialog.adaptive(
        title: const Text('A D D  E X P E N S E:'),
        content: SizedBox(
          height: 200,
          child: Column(
            children: [
              // Input field for expense purpose
              TextFromUser(
                controller: textFieldController,
                hintText: "Enter Purpose",
                keyboardType: TextInputType.text,
                labelText: 'Purpose',
                obscureText: false,
                icon: Icons.abc,
              ),
              SizedBox(
                height: 15,
              ),
              // Input field for expense amount
              TextFromUser(
                controller: moneyFieldController,
                hintText: "Enter Amount",
                keyboardType: TextInputType.number,
                labelText: 'Amount',
                obscureText: false,
                icon: Icons.abc,
              ),
              SizedBox(
                height: 15,
              ),
              // Dropdown for selecting category
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.account_balance_wallet_outlined),
                  labelText: 'Category',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  fillColor: Theme.of(context).colorScheme.surface,
                  filled: true,
                ),
                value: selectedCategory,
                items: <String>['Food', 'Transport', 'Bills']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  selectedCategory = newValue!;
                },
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
                category: selectedCategory,
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
