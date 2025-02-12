part of '../home_page.dart';

String getMonthAbbreviation(int month) {
  const months = [
    'JAN',
    'FEB',
    'MAR',
    'APR',
    'MAY',
    'JUN',
    'JUL',
    'AUG',
    'SEP',
    'OCT',
    'NOV',
    'DEC'
  ];
  return months[month - 1];
}

Positioned dateTitle(
    DateTime selectedDate, bool isToday, BuildContext context) {
  return Positioned(
    top: 24,
    right: 14,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              getMonthAbbreviation(selectedDate.month),
              style: const TextStyle(
                fontSize: 74,
                fontWeight: FontWeight.w100,
              ),
            ),
            Text(
              selectedDate.day.toString(),
              style: TextStyle(
                fontSize: 74,
                fontWeight: FontWeight.w400,
                color: isToday ? Theme.of(context).colorScheme.secondary : null,
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 2.0),
          height: 1.0,
          width: 300,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(0, 131, 130, 130),
                Theme.of(context).colorScheme.secondary,
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
