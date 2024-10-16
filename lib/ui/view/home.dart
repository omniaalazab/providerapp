import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:providerapp/helper/color_helper.dart';
import 'package:providerapp/ui/view/dashboard.dart';
import 'package:providerapp/ui/view/notification.dart';
import 'package:providerapp/ui/view/profile.dart';
import 'package:providerapp/ui/view/ticket.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  int selectedIndex = 0;
  List<String> imagePath = [
    "assets/images/Home.png",
    "assets/images/Ticket.png",
    "assets/images/Notification.png",
    "assets/images/Profile1.png",
  ];
  List<Map<String, dynamic>> screens = [
    {
      'screen': const DashBoard(),
    },
    {
      'screen': const Ticket(),
    },
    {
      'screen': const NotificationPage(),
    },
    {
      'screen': const ProfileScreen(),
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        //  backgroundColor: ColorHelper.darkpurple,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        itemCount: imagePath.length,
        tabBuilder: (index, isActive) {
          return Image(
              image: AssetImage(imagePath[index]),
              color: isActive ? ColorHelper.purple : ColorHelper.darkgrey);
        },
        activeIndex: selectedIndex,
        gapLocation: GapLocation.none,
        notchSmoothness: NotchSmoothness.smoothEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
      ),
      body: Center(
        child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: screens[selectedIndex]['screen']),
      ),
    );
  }
}
