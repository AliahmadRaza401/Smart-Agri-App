import 'package:flutter/material.dart';
import 'package:smart_agri/trader_screens/daily_updates.dart';
import 'package:smart_agri/trader_screens/farmers.dart';
import 'package:smart_agri/trader_screens/home/home.dart';
import 'package:smart_agri/trader_screens/profile.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentPage = 0;
  final GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myWhite,
      body: Container(
        child: Center(
          child: _getPage(currentPage),
        ),
      ),
      bottomNavigationBar: WaterDropNavBar(
        key: _bottomNavigationKey,
        backgroundColor: myGreen,
        waterDropColor: myWhite,
        onItemSelected: (index) {
          setState(() {
            currentPage = index;
          });
        },
        selectedIndex: currentPage,
        barItems: [
          BarItem(
            filledIcon: Icons.home_filled,
            outlinedIcon: Icons.home_outlined,
          ),
          BarItem(
            filledIcon: Icons.supervised_user_circle_rounded,
            outlinedIcon: Icons.supervised_user_circle_outlined,
          ),
          BarItem(
            filledIcon: Icons.calendar_today_rounded,
            outlinedIcon: Icons.calendar_today_outlined,
          ),
          BarItem(
            filledIcon: Icons.person,
            outlinedIcon: Icons.person_outline,
          ),
        ],
      ),
    );
  }

  _getPage(int page) {
    switch (page) {
      case 0:
        return const Home();
      case 1:
        return const Farmers();
      case 2:
        return const DailyUpdates();
      case 3:
        return const Profile();
      default:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            Text(
              ('TabBar Index Error'),
            ),
          ],
        );
    }
  }
}
