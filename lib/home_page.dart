import 'package:e_tracker/models/expense_m.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_todo.dart';
import 'cubit/expense_cubit.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: BlocBuilder<ExpenseCubit, List<Expense>>(
        builder: (context, expenses) {
          return ListView.builder(
            itemCount: expenses.length,
            itemBuilder: (context, index) {
              final expense = expenses[index];
              return ListTile(
                leading: Text('${index + 1}.'),
                title: Text(expense.name),
                trailing: IconButton(
                  icon: const Icon(Icons.done_rounded),
                  onPressed: () {
                    context.read<ExpenseCubit>().removeTodo(expense);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Task completed!',
                              style: TextStyle(color: Colors.white),
                            ),
                            TextButton(
                              onPressed: () {
                                context.read<ExpenseCubit>().addTodo(
                                      expense.name,
                                      expense.price,
                                    );
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                              },
                              child: const Text(
                                'Undo',
                                style: TextStyle(color: Colors.purple),
                              ),
                            ),
                          ],
                        ),
                        backgroundColor: Colors.black,
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        foregroundColor: Colors.white,
        onPressed: () => displayTextInputDialog(context),
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
