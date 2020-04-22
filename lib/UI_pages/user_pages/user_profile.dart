import 'package:flutter/material.dart';
import 'package:kronogram/UI_pages/user_pages/user_timeline.dart';
import 'package:kronogram/UI_pages/values/colors.dart';
import 'package:kronogram/services/globals.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key key, this.userId})
      :super(key:key);

  final String userId;

  @override
  State<StatefulWidget> createState() {
    return _UserProfileState();
  }
}

class _UserProfileState extends State<UserProfile> {
  List<String> followingUsernames;
  List<String> followingIDs;
  List<String> followerUsernames;
  List<Map> followerIDs;
  bool loading;

  void getFollowingUsernames(String userID) async {
    followingIDs = await db.getFollowingIDs(userID);
    for(var id in followingIDs) {
      String username = await db.getUsername(id);
      followingUsernames.add(username);
    }
    setState(() {
      loading = false;
    });
  }

  void getFollowersUsernames(String userID) async {
    followerIDs = await db.getFollowersIDsAndStatus(userID);
    for(var user in followerIDs) {
      String username = await db.getUsername(user['userID']);
      followerUsernames.add(username);
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    loading = true;
    followingUsernames = new List();
    followerUsernames = new List();
    getFollowingUsernames(widget.userId);
    getFollowersUsernames(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          backgroundColor: AppColors.appBarBackground,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.timeline), text: 'TIMELINE',),
              Tab(icon: Icon(Icons.people), text: 'FOLLOWING',),
              Tab(icon: Icon(Icons.people_outline), text: 'FOLLOWERS',),
            ],
            indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Timeline(userId: widget.userId),
            followingTab(),
            followersTab(),
          ],
        ),
      ),
    );
  }

  Widget followingTab() {
    if(loading) {
      return Container(
      );
    }
    else if(followingUsernames.length == 0) {
      return Container(
        child: Text(
          'You are not following any users',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal
          ),
        ),
      );
    }
    else {
      return Container(
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: followingUsernames.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          '@' + followingUsernames[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        showUnfollowButton(followingIDs[index])
                      ],
                    )
                  ],
                ),
              );
            }
        )
      );
    }
  }

  Widget showUnfollowButton(String friendID) {
    return new Padding(
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
        child: SizedBox(
          height: 30.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: AppColors.voidBackground7,
            child: new Text('Unfollow',
                style: new TextStyle(
                    fontSize: 15.0, color: AppColors.randomButtonText2)),
            onPressed: () => onUnfollowPressed(friendID),
          ),
        ));
  }

  Widget showFollowButton(String friendID) {
    return new Padding(
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
        child: SizedBox(
          height: 30.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: AppColors.voidBackground7,
            child: new Text('Follow',
                style: new TextStyle(
                    fontSize: 15.0, color: AppColors.randomButtonText2)),
            onPressed: () => onFollowPressed(friendID),
          ),
        ));
  }

  Widget followersTab() {
    if(loading) {
      return Container(
      );
    }
    else if(followerUsernames.length == 0) {
      return Container(
        child: Text(
          'You do not have any followers',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal
          ),
        ),
      );
    }
    else {
      return Container(
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: followerUsernames.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          '@' + followerUsernames[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        showFollowUnfollowButton(followerIDs[index]['status'], followerIDs[index]['userID'])
                      ],
                    )
                  ],
                ),
              );
            }
        ),
      );
    }
  }

  Widget showFollowUnfollowButton(int code, String friendID) {
    if(code == 3) return showUnfollowButton(friendID);
    else return showFollowButton(friendID);
  }

  void onUnfollowPressed(String friendID) async {
    await db.unfollowFriend(widget.userId, friendID);
    setState(() {
      loading = true;
      followingUsernames = new List();
      followerUsernames = new List();
      getFollowingUsernames(widget.userId);
      getFollowersUsernames(widget.userId);
    });
  }

  void onFollowPressed(String friendID) async {
    await db.followFriend(widget.userId, friendID);
    setState(() {
      loading = true;
      followingUsernames = new List();
      followerUsernames = new List();
      getFollowingUsernames(widget.userId);
      getFollowersUsernames(widget.userId);
    });
  }
  
}