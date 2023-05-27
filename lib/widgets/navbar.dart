// ignore_for_file: unused_local_variable, prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:komik_app/colors.dart';
import 'package:komik_app/screens/favorite.dart';
import 'package:komik_app/screens/history.dart';
import 'package:komik_app/screens/home.dart';
import 'package:komik_app/screens/info.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  PageController pageController = PageController(initialPage: 0);
  int selectedIndex = 0;
  
  void onTapItem(int i) {
    setState(() {
      pageController.animateToPage(
        i,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
      selectedIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [Home(), Favorite(), History(), Info()];
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Get.width / 20, vertical: Get.width / 15),
        child: BottomNavigationBar(
          showUnselectedLabels: false,
          showSelectedLabels: false,
          currentIndex: selectedIndex,
          unselectedItemColor: Colors.white,
          selectedItemColor: blueTheme,
          backgroundColor: Color(0xff23252F),
          type: BottomNavigationBarType.fixed,
          onTap: onTapItem,
          items: [
            BottomNavigationBarItem(
                icon:
                    Icon(selectedIndex == 0 ? Iconsax.home_25 : Iconsax.home_2),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(selectedIndex == 1 ? Iconsax.heart5 : Iconsax.heart),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(selectedIndex == 2 ? Iconsax.clock5 : Iconsax.clock),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(selectedIndex == 3
                    ? Iconsax.more_circle5
                    : Iconsax.more_circle),
                label: ""),
          ],
        ),
      ),
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: screens,
      ),
    );
  }
}
