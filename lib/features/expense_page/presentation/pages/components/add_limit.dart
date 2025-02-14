import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/expense_m.dart';
import '../../cubit/expense_cubit.dart';

Future<double?> showEditLimitDialog(
    BuildContext context, double currentLimit) async {
  final TextEditingController limitController = TextEditingController();
  return showDialog<double>(
    context: context,
    builder: (context) {
      return AlertDialog.adaptive(
        title: const Text(
          'Edit Monthly Limit: ',
          style: TextStyle(
            fontSize: 22,
          ),
          textAlign: TextAlign.center,
        ),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Current Limit: ₹${currentLimit.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: limitController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter new limit',
                labelText: 'New Limit',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            BlocBuilder<ExpenseCubit, List<Expense>>(
              builder: (context, expenses) {
                final categoryTotals = <String, double>{};
                for (var expense in expenses) {
                  categoryTotals.update(
                    expense.category,
                    (value) => value + double.parse(expense.price),
                    ifAbsent: () => double.parse(expense.price),
                  );
                }
                final totalExpense =
                    categoryTotals.values.fold(0.0, (a, b) => a + b);
                final colors = [
                  Colors.blue,
                  Colors.red,
                  Colors.green,
                  Colors.orange,
                  Colors.purple,
                  Colors.yellow,
                ];
                return Column(
                  children: [
                    SizedBox(
                      height: 200, // Set a fixed height for the PieChart
                      child: PieChart(
                        PieChartData(
                          sections: categoryTotals.entries.map((entry) {
                            final percentage =
                                (entry.value / totalExpense) * 100;
                            final color = colors[categoryTotals.keys
                                    .toList()
                                    .indexOf(entry.key) %
                                colors.length];
                            return PieChartSectionData(
                              value: percentage,
                              title: '${percentage.toStringAsFixed(1)}%',
                              color: color,
                              radius: 50,
                              titleStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            );
                          }).toList(),
                          sectionsSpace: 2,
                          centerSpaceRadius: 40,
                          borderData: FlBorderData(show: false),
                          pieTouchData: PieTouchData(
                            touchCallback:
                                (FlTouchEvent event, pieTouchResponse) {
                              if (!event.isInterestedForInteractions ||
                                  pieTouchResponse == null ||
                                  pieTouchResponse.touchedSection == null) {
                                return;
                              }
                              // Handle touch interactions if needed
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: categoryTotals.entries.map((entry) {
                        final color = colors[
                            categoryTotals.keys.toList().indexOf(entry.key) %
                                colors.length];
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              color: color,
                            ),
                            const SizedBox(width: 4),
                            Text(entry.key),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                );
              },
            ),
          ],
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
              final limit = double.tryParse(limitController.text.trim());
              if (limit != null) {
                Navigator.pop(context, limit);
              } else {
                Navigator.pop(context);
              }
            },
          ),
        ],
      );
    },
  );
}
