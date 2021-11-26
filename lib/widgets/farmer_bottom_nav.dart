import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:smart_agri/farmer_screens/farmer_home_screen.dart';
import 'package:smart_agri/trader_screens/notifications_screen/notification_page.dart';
import 'package:smart_agri/trader_screens/profile/profile.dart';
import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/widgets/dynamic_size.dart';

class FarmerBottomNav extends StatefulWidget {
  final dynamic farmerId;

  const FarmerBottomNav({Key? key, this.farmerId}) : super(key: key);

  @override
  _FarmerBottomNavState createState() => _FarmerBottomNavState();
}

class _FarmerBottomNavState extends State<FarmerBottomNav> {
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
            icon: const Icon(Icons.notifications),
            title: Text(
              "Notifications",
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
        return FarmerHomeScreen(
          farmerId: widget.farmerId,
        );
      case 1:
        return const NotificationPage();
      case 2:
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
