import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/config/theme/internal_background.dart';
import '../../../../common/widgets/index.dart';
import '../../../settings/presentation/pages/settings_page.dart';
import '../cubit/day_cubit.dart';

part 'components/custom_drawer.dart';
part 'components/date_title.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => DayCubit()),
      ],
      child: HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  final int todayIndex = DateTime.now().weekday - 1;
  UserProfile? userProfile;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  DateTime getDateForIndex(int index) {
    final now = DateTime.now();
    final difference = index - todayIndex;
    return now.add(Duration(days: difference));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: InternalBackground(
        child: BlocBuilder<DayCubit, DayState>(
          builder: (context, state) {
            final selectedDate = getDateForIndex(state.selectedIndex);
            final isToday = state.selectedIndex == todayIndex;
            return homeMainColumn(selectedDate, isToday, context, state);
          },
        ),
      ),
      drawerScrimColor: const Color.fromARGB(10, 0, 0, 0),
      onDrawerChanged: (isOpen) {
        context.read<DayCubit>().toggleDrawer(isOpen);
      },
      drawer: const CustomDrawer(),
    );
  }

  Stack homeMainColumn(DateTime selectedDate, bool isToday,
      BuildContext context, DayState state) {
    return Stack(
      children: [
        dateTitle(selectedDate, isToday, context),
        buildPostsList(),
        buildCustomNavButton(state),
        PageTitleSideWays(
          isDrawerOpen: state.isDrawerOpen,
          pageTitle: 'ROOM STATUS',
        ),
        buildBottomGradient(context),
        buildCreatePostButton(context),
      ],
    );
  }

  Positioned buildPostsList() {
    return Positioned(
      top: 132,
      left: 80,
      right: -6,
      bottom: 75,
      child: ClipRect(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: const Column(
            children: [],
          ),
        ),
      ),
    );
  }

  Positioned buildCustomNavButton(DayState state) {
    return Positioned(
      top: 44,
      left: 14,
      child: CustomNavButton(
        icon: Icons.menu,
        onTap: () {
          context.read<DayCubit>().toggleDrawer(true);
          scaffoldKey.currentState?.openDrawer();
        },
        isRotated: state.isDrawerOpen,
      ),
    );
  }

  Positioned buildBottomGradient(BuildContext context) {
    return Positioned(
      bottom: 65,
      right: 14,
      child: Container(
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
    );
  }

  Positioned buildCreatePostButton(BuildContext context) {
    return Positioned(
      bottom: 35,
      right: 20,
      child: GestureDetector(
        onTap: () {
          // showUploadBottomSheet(context, userProfile!);
        },
        child: const Text('A D D  E X P E N S E'),
      ),
    );
  }
}
