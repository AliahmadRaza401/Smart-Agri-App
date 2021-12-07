import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:smart_agri/trader_screens/daily_update/daily_updates.dart';
import 'package:smart_agri/trader_screens/farmers/farmers.dart';
import 'package:smart_agri/trader_screens/home/home.dart';
import 'package:smart_agri/trader_screens/notifications_screen/notification_page.dart';
import 'package:smart_agri/trader_screens/profile/profile.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/widgets/dynamic_size.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myWhite,
      body: Center(
        child: _getPage(currentPage),
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: currentPage,
        onTap: (i) => setState(() => currentPage = i),
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: Text(
              "Home",
              style: TextStyle(
                fontSize: dynamicWidth(context, .036),
              ),
            ),
            selectedColor: myGreen,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.supervised_user_circle_rounded),
            title: Text(
              "Farmers",
              style: TextStyle(
                fontSize: dynamicWidth(context, .036),
              ),
            ),
            selectedColor: myGreen,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.calendar_today),
            title: Text(
              "Updates",
              style: TextStyle(
                fontSize: dynamicWidth(context, .036),
              ),
            ),
            selectedColor: myGreen,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.notifications),
            title: Text(
              "Requests",
              style: TextStyle(
                fontSize: dynamicWidth(context, .036),
              ),
            ),
            selectedColor: myGreen,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.person),
            title: Text(
              "Profile",
              style: TextStyle(
                fontSize: dynamicWidth(context, .036),
              ),
            ),
            selectedColor: myGreen,
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
        return const NotificationPage();
      case 4:
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
