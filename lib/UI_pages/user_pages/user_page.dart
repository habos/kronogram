import 'package:flutter/material.dart';
import 'package:kronogram/services/authentication.dart';
import 'package:kronogram/UI_pages/values/values.dart';

import 'package:kronogram/UI_pages/user_pages/user_timeline.dart';
import 'package:kronogram/UI_pages/user_pages/user_feed.dart';
import 'package:kronogram/UI_pages/my_app_bar/my_app_bar.dart';
//import 'package:kronogram/UI_pages/display_posts/display_posts.dart';

class UserPage extends StatefulWidget{
  UserPage({Key key, this.auth, this.userId})
        :super(key:key);

  final BaseAuth auth;
  final String userId;

  @override
  State<StatefulWidget> createState(){
    return _UserPageState();
  }

}
class _UserPageState extends State<UserPage>{
  int _currentIndex = 0;
  final List<Widget> _children = [
    userFeed(),
    userFeed(),
    PlaceholderWidget(Colors.white)
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(110.0),
        child: myAppBar(
          //height: 100,
        ),
      ),
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        selectedItemColor: AppColors.selectedTabBar,
        unselectedItemColor: AppColors.unSelectedTabBar,
        currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text('TODAY'),

          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.storage),
            title: Text('TIMELINE'),
          ),
          new BottomNavigationBarItem(
              icon: Icon(Icons.public),
              title: Text('MAP')
          )
        ],
      ),
    );
  }
    void onTabTapped(int index) {
      setState(() {
        _currentIndex = index;
      });
    }
  }








