import 'package:flutter/material.dart';
import 'package:kronogram/services/authentication.dart';
import 'package:kronogram/UI_pages/values/values.dart';
import 'package:kronogram/services/globals.dart' as globals;

import 'package:kronogram/UI_pages/user_pages/user_timeline.dart';
import 'package:kronogram/UI_pages/user_pages/user_feed.dart';
import 'package:kronogram/UI_pages/my_app_bar/my_app_bar.dart';
import 'package:kronogram/services/database.dart';
//import 'package:kronogram/UI_pages/display_posts/display_posts.dart';

class UserPage extends StatefulWidget{
  UserPage({Key key, this.userId, this.logoutCallback})
        :super(key:key);

  final BaseAuth auth = globals.auth;
  final String userId;
  final VoidCallback logoutCallback;
  final Database db = globals.db;
  String username = "error";

  @override
  State<StatefulWidget> createState(){
    return _UserPageState();
  }

}
class _UserPageState extends State<UserPage>{
  int _currentIndex = 0;
  final List<Widget> _children = [
    userFeed(today:true),
    Timeline(),
    PlaceholderWidget(Colors.white)
  ];

  void setUsername(String userId) async{
    String user = await widget.db.getUsername(userId);
    setState(() {
      widget.username = user;
    });
  }
  @override
  void initState(){
    super.initState();
    setState(() {
      setUsername(widget.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(110.0),
        child: myAppBar(userId: widget.userId, logoutCallback: widget.logoutCallback, username: widget.username,
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








