import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../../domain/entities/expense_m.dart';

class ExpenseCubit extends Cubit<List<Expense>> {
  ExpenseCubit() : super([]) {
    _loadExpenses();
  }

  double monthlyBudget = 10000.0;

  void addExpense(String title, String money, String category) {
    if (title.isEmpty) {
      emitError('Task cannot be empty');
      return;
    }

    if (state.any((expense) => expense.name == title)) {
      emitError('Task already exists');
      return;
    }

    if (money.isEmpty) {
      emitError('Enter a valid price');
      return;
    }

    final expense = Expense(
      name: title,
      createdAt: DateTime.now(),
      price: money,
      category: category,
    );

    emit([...state, expense]);
    _saveExpenses();
    _checkBudget();
  }

  void emitError(String message) {
    // Custom method to emit an error state
    addError(Exception(message), StackTrace.current);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    // Emit current state to trigger listener and handle the error
    emit(state);
    super.onError(error, stackTrace);
  }

  void removeExpense(Expense expense) {
    emit(state.where((t) => t != expense).toList());
    _saveExpenses();
  }

  Future<void> _saveExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    final expensesJson = jsonEncode(state.map((e) => e.toJson()).toList());
    await prefs.setString('expenses', expensesJson);
  }

  Future<void> _loadExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    final expensesJson = prefs.getString('expenses');
    if (expensesJson != null) {
      final List<dynamic> expensesList = jsonDecode(expensesJson);
      final expenses = expensesList.map((e) => Expense.fromJson(e)).toList();
      emit(expenses);
    }
  }

  void _checkBudget() {
    final totalExpense = state.fold<double>(
      0,
      (sum, expense) => sum + double.parse(expense.price),
    );
    if (totalExpense > monthlyBudget) {
      emitError('Monthly budget exceeded');
    }
  }

  @override
  void onChange(Change<List<Expense>> change) {
    super.onChange(change);
  }
}
