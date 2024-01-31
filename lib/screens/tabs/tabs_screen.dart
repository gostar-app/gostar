import 'package:flutter/material.dart';
import 'package:gostar/screens/tabs/home_tab.dart';
import 'package:gostar/screens/tabs/profile_tab.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _currentTab = 0;

  void onChangeTab(int index) {
    setState(() {
      _currentTab = index;
    });
  }

  final tabs = [const HomeTab(), Container(), const ProfileTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: tabs[_currentTab]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTab,
        onTap: onChangeTab,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
