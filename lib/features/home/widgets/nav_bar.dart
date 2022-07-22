import 'package:flutter/material.dart';
import 'package:routine_checks_mobile/features/add_routine/pages/add_routine.dart';
import 'package:routine_checks_mobile/features/home/pages/home_page.dart';
import 'package:routine_checks_mobile/features/up_next/pages/up_next.dart';
import 'package:routine_checks_mobile/utils/colors.dart';


class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentIndex = 0;
  _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Up Next',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Add Routine',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: AppColors.purple,
      onTap: (int index) {
        setState(() {
          currentIndex = index;
        });
      },
    );
  }

  _buildChild({required int currentIndex}) {
    switch (currentIndex) {
      case 0:
        return const Home();
      case 1:
        return const UpNext();
      case 2:
        return const AddRoutine();
      default:
        return const Home();
    }
  }

  _buildFab() {
    return FloatingActionButton(
      onPressed: () {
        setState(() {
          currentIndex = 2;
        });
      },
      backgroundColor: AppColors.purple,
      child: const Icon(Icons.add),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: _buildFab(),
      body: _buildChild(currentIndex: currentIndex),
    );
  }
}
