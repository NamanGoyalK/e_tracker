import 'package:e_tracker/features/expense_page/domain/entities/expense_m.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/add_expense.dart';
import '../cubit/expense_cubit.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedCategory = 'All'; // Default category

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 28,
          ),
        ),
      ),
      body: Column(
        children: [
          // Display total expense
          BlocBuilder<ExpenseCubit, List<Expense>>(
            builder: (context, expenses) {
              final totalExpense = expenses.fold<double>(
                0,
                (sum, expense) => sum + double.parse(expense.price),
              );
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 1,
                          offset: Offset(1, 1),
                        )
                      ]),
                  child: Center(
                    child: Text(
                      'Total Expense: ₹$totalExpense',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          // Dropdown for category selection
          DropdownButton<String>(
            value: selectedCategory,
            items: <String>['All', 'Food', 'Transport', 'Bills']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedCategory = newValue!;
              });
            },
          ),
          // Display list of expenses
          Expanded(
            child: BlocBuilder<ExpenseCubit, List<Expense>>(
              builder: (context, expenses) {
                final filteredExpenses = selectedCategory == 'All'
                    ? expenses
                    : expenses
                        .where(
                            (expense) => expense.category == selectedCategory)
                        .toList();
                return ListView.builder(
                  itemCount: filteredExpenses.length,
                  itemBuilder: (context, index) {
                    final expense = filteredExpenses[index];
                    return Dismissible(
                      key: Key(expense.createdAt.toString()),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        BlocProvider.of<ExpenseCubit>(context)
                            .removeExpense(expense);
                      },
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      child: ListTile(
                        leading: Text(
                          '${index + 1}.',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        title: Text(
                          expense.name.toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          expense.createdAt.toString().split('.')[0],
                        ),
                        trailing: Text(
                          '⌁ ₹${expense.price}',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.error,
                            fontSize: 28,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        elevation: 4,
        onPressed: () => displayTextInputDialog(context),
        tooltip: 'A D D  E X P E N S E',
        child: const Icon(Icons.add),
      ),
    );
  }
}
