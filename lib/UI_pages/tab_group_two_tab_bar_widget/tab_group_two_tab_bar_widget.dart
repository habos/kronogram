import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kronogram/UI_pages/user_current_date_widget/user_current_date_widget.dart';
import 'package:kronogram/UI_pages/user_map_widget/user_map_widget.dart';
import 'package:kronogram/UI_pages/user_timeline_widget/user_timeline_widget.dart';

class TabGroupTwoTabBarWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TabGroupTwoTabBarWidgetState();
}

class _TabGroupTwoTabBarWidgetState extends State<TabGroupTwoTabBarWidget> {
  List<Widget> _tabWidgets = [
    UserCurrentDateWidget(),
    UserTimelineWidget(),
    UserMapWidget(),
  ];
  int _currentIndex = 0;

  void _onTabChanged(int index) => this.setState(() => _currentIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabWidgets[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Color.fromARGB(255, 112, 112, 112),
        currentIndex: _currentIndex,
        onTap: (index) => this._onTabChanged(index),
        items: [
          BottomNavigationBarItem(
            title: Text(
              "CURRENT  DATE",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ),
          BottomNavigationBarItem(
            title: Text(
              "TIMELINE",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ),
          BottomNavigationBarItem(
            title: Text(
              "MAP",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
