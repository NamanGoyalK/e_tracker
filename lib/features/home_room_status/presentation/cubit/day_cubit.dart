import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'day_state.dart';

// Cubit to manage the state of the selected day
class DayCubit extends Cubit<DayState> {
  DayCubit() : super(DayState(DateTime.now().weekday - 1, false));

  void selectDay(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  void toggleDrawer(bool isOpen) => emit(state.copyWith(isDrawerOpen: isOpen));
}
