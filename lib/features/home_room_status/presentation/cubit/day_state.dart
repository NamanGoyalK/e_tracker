part of 'day_cubit.dart';

@immutable
class DayState {
  final int selectedIndex;
  final bool isDrawerOpen;

  const DayState(this.selectedIndex, this.isDrawerOpen);

  DayState copyWith({int? selectedIndex, bool? isDrawerOpen}) {
    return DayState(
      selectedIndex ?? this.selectedIndex,
      isDrawerOpen ?? this.isDrawerOpen,
    );
  }
}
