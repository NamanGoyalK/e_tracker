import 'package:e_tracker/common/widgets/index.dart';
import 'package:e_tracker/features/expense_page/domain/entities/expense_m.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'components/add_expense.dart';
import '../cubit/expense_cubit.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showSnackBar(
        context,
        'Tap add to add expense & swipe left to delete.',
        Colors.cyan,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 28,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
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
          Padding(
            padding:
                const EdgeInsets.only(left: 14.0, right: 14.0, bottom: 12.0),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.account_balance_wallet_outlined),
                labelText: 'Category',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                fillColor: Theme.of(context).colorScheme.surface,
                filled: true,
              ),
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
          ),
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
                        color: const Color.fromARGB(255, 236, 31, 16),
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
                            color: const Color.fromARGB(255, 236, 31, 16),
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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('© Developed by ',
                    style: TextStyle(
                      color: Colors.grey,
                    )),
                GestureDetector(
                  onTap: () async {
                    const url = 'https://www.linkedin.com/in/naman-goyal-dev';
                    final uri = Uri.parse(url);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: Text('Naman Goyal'),
                ),
              ],
            ),
          )
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
