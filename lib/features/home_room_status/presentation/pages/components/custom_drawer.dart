part of '../home_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Drawer(
      width: 70,
      elevation: 0,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Padding(
        padding: EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: WeekButtonsColumn(),
            ),
            NavButtonsColumn(),
          ],
        ),
      ),
    );
  }
}

class NavButtonsColumn extends StatelessWidget {
  const NavButtonsColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 9.0),
      child: Column(
        children: [
          NavButton(
            icon: Icons.people,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          NavButton(
            icon: Icons.settings_outlined,
            onTap: () {
              // Popping drawer closes it
              Navigator.pop(context);

              // Navigating to settings
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(),
                ),
              );
            },
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

class WeekButtonsColumn extends StatelessWidget {
  const WeekButtonsColumn({super.key});

  @override
  Widget build(BuildContext context) {
    final int todayIndex = DateTime.now().weekday - 1;
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, left: 8.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              context.read<DayCubit>().toggleDrawer(false);
              Navigator.of(context).pop(); // Ensure drawer closes
            },
            child: Container(
              height: 60,
              width: 60,
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                color: Color.fromARGB(0, 255, 255, 255),
              ),
            ),
          ),
          Column(
            children: List.generate(7, (index) {
              return BlocBuilder<DayCubit, DayState>(
                builder: (context, state) {
                  bool isToday = index == todayIndex;
                  return DrawerWeekButton(
                    day: 'MTWTFSS'[index],
                    isSelected: state.selectedIndex == index,
                    isToday: isToday,
                    onTap: () {
                      context.read<DayCubit>().selectDay(
                            index,
                          );
                      context.read<DayCubit>().toggleDrawer(false);
                      Navigator.of(context).pop(); // Ensure drawer closes
                    },
                    isEnabled: true,
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
