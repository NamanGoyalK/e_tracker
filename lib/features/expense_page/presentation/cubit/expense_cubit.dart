import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/expense_m.dart';

class ExpenseCubit extends Cubit<List<Expense>> {
  ExpenseCubit() : super([]) {
    _loadExpenses();
  }

  void addExpense(Expense expense) {
    if (expense.name.isEmpty) {
      emitError('Task cannot be empty');
      return;
    }

    if (state.any((e) => e.name == expense.name)) {
      emitError('Task already exists');
      return;
    }

    if (expense.price.isEmpty) {
      emitError('Enter a valid price');
      return;
    }

    emit([...state, expense]);
    _saveExpenses();
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
    emit(state.where((e) => e != expense).toList());
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

  @override
  void onChange(Change<List<Expense>> change) {
    super.onChange(change);
  }
}
