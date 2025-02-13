import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/expense_m.dart';

class ExpenseCubit extends Cubit<List<Expense>> {
  ExpenseCubit() : super([]);

  void addTodo(String title, String money) {
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
    );

    emit([...state, expense]);
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

  void removeTodo(Expense expense) {
    emit(state.where((t) => t != expense).toList());
  }

  @override
  void onChange(Change<List<Expense>> change) {
    super.onChange(change);
  }
}
