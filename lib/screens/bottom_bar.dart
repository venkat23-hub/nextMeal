import 'package:flutter/material.dart';
import 'package:nextmeal/data/dummy_data.dart';
import 'package:nextmeal/screens/explore_page.dart';
import 'package:nextmeal/screens/home_screen.dart';
import 'package:nextmeal/screens/orders_page.dart';
import 'package:nextmeal/screens/profile_page.dart';
import 'package:flutter/scheduler.dart';

class BottomBarScreen extends StatefulWidget {
  BottomBarScreen({super.key, this.selectedPageIndex});
  late int? selectedPageIndex;

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {


  final List<Map<String, dynamic>> pages = [
    {'page': '', 'title': 'Home'},
    {'page': '', 'title': 'Explore'},
    {'page': '', 'title': 'Orders'},
    {'page': '', 'title': 'profile'},
  ];

  void ChangePage(int index) {
    setState(() {
      widget.selectedPageIndex = index;
    });
  }
  var brightness =
      SchedulerBinding.instance.platformDispatcher.platformBrightness;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = brightness == Brightness.dark;

    pages[0]['page'] = HomeScreenPage(availableMeals: dummyMeals);
    pages[1]['page'] = ExplorePage();
    pages[2]['page'] = OrdersPage();
    pages[3]['page'] = ProfilePage();

    int selectedPageIndexDef = widget.selectedPageIndex ?? 0;
    return Scaffold(
      backgroundColor: Colors.black,
      body: pages[selectedPageIndexDef]['page'],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.redAccent.shade700,
        onTap: (currentIndex) => {ChangePage(currentIndex)},
        currentIndex: selectedPageIndexDef,
        selectedItemColor: Colors.white, // Color for the selected label text
        unselectedItemColor: Colors.white70,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.white,
              size: 35,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.explore,
              color: Colors.white,
              size: 35,
            ),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
              size: 35,
            ),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_2_outlined,
              color: Colors.white,
              size: 35,
            ),
            label: 'Profile',
          )
        ],
      ),
    );
  }
}
