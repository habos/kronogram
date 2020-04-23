import 'package:flutter/material.dart';
import 'package:kronogram/UI_pages/user_pages/user_map.dart';
import 'package:kronogram/UI_pages/user_pages/user_timeline.dart';
import 'package:kronogram/UI_pages/values/colors.dart';
import 'package:kronogram/services/globals.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key key, this.userId, this.viewId})
      :super(key:key);
  //userId is the id of the logged in user
  //viewId is the id of the user whos page you are viewing
  //they should be the same when the user is viewing his/her own page
  final String userId;
  final String viewId;

  @override
  State<StatefulWidget> createState() {
    return _UserProfileState();
  }
}

class _UserProfileState extends State<UserProfile> {
  List<String> userFollowingIDs;
  List<String> followingUsernames;
  List<String> followingIDs;
  List<String> followerUsernames;
  List<Map> followerIDs;
  String otherUserName;
  bool loading = true;


  Future<void> getFollowingUsernames(String userID) async {
    followingIDs = await db.getFollowingIDs(userID);
    for(var id in followingIDs) {
      String username = await db.getUsername(id);
      followingUsernames.add(username);
    }
  }

  Future<void> getFollowersUsernames(String userID) async {
    followerIDs = await db.getFollowersIDsAndStatus(userID);
    for(var user in followerIDs) {
      String username = await db.getUsername(user['userID']);
      followerUsernames.add(username);
    }
  }

  Future<void> getUserFollowingIDs(String userID) async {
    userFollowingIDs = await db.getFollowingIDs(userID);
    return;
  }

  void getAllLists() async {
    followingUsernames = new List();
    followerUsernames = new List();
    await getUserFollowingIDs(widget.userId);
    await getFollowingUsernames(widget.viewId);
    await getFollowersUsernames(widget.viewId);
    setState(() {
      loading = false;
    });
    return;
  }

  @override
  void initState() {
    // TODO: implement initState
    loading = true;
    getOtherUserName();
    getAllLists();
    super.initState();
  }

  Future<void> getOtherUserName() async {
    if(widget.viewId != widget.userId) otherUserName = await db.getUsername(widget.viewId);
  }

  Widget showUserTitle() {
    if(widget.viewId == widget.userId || loading==true) return Container();
    else return Container(
        child: Row(
          children: <Widget>[
            Text('@'+otherUserName),
            showFollowUnfollowButton(widget.viewId)
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    if(widget.viewId != widget.userId) {
      return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            leading: widget.viewId == widget.userId ? Container() : null,
            backgroundColor: AppColors.appBarBackground,
            bottom: TabBar(
              tabs: <Widget>[
                Tab(icon: Icon(Icons.timeline), text: 'TIMELINE',),
                Tab(icon: Icon(Icons.public), text: 'MAP',),
                Tab(icon: Icon(Icons.people), text: 'FOLLOWING',),
                Tab(icon: Icon(Icons.people_outline), text: 'FOLLOWERS',),
              ],
              indicatorColor: Colors.white,
                labelStyle: TextStyle(
                    fontSize: 10
                ),
            ),
            title: showUserTitle(),
          ),
          body: TabBarView(
            children: <Widget>[
              Timeline(userId: widget.viewId),
              UserMap(userId: widget.viewId,),
              followingTab(),
              followersTab(),
            ],
          ),
        ),
      );
    }
    else {
      return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            leading: widget.viewId == widget.userId ? Container() : null,
            backgroundColor: AppColors.appBarBackground,
            bottom: TabBar(
              tabs: <Widget>[
                Tab(icon: Icon(Icons.timeline), text: 'TIMELINE',),
                Tab(icon: Icon(Icons.people), text: 'FOLLOWING',),
                Tab(icon: Icon(Icons.people_outline), text: 'FOLLOWERS',),
              ],
              indicatorColor: Colors.white,
            ),
            title: showUserTitle(),
          ),
          body: TabBarView(
            children: <Widget>[
              Timeline(userId: widget.viewId),
              followingTab(),
              followersTab(),
            ],
          ),
        ),
      );
    }
  }

  Widget followingTab() {
    if(loading) {
      return Container(
      );
    }

    else if(followingUsernames.length == 0) {
      return Container(
        child: Text(
          'Not following any users',
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
                        FlatButton(
                          child: Text(
                            '@' + followingUsernames[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          onPressed: () => onViewPressed(context, followingIDs[index]),
                        ),
                        showFollowUnfollowButton(followingIDs[index]),
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

  Widget followersTab() {
    if(loading) {
      return Container(
      );
    }
    else if(followerUsernames.length == 0) {
      return Container(
        child: Text(
          'No followers',
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
                        FlatButton(
                          child: Text(
                            '@' + followerUsernames[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          onPressed: () => onViewPressed(context, followerIDs[index]['userID']),
                        ),
                        showFollowUnfollowButton(followerIDs[index]['userID'])
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

  Widget showFollowUnfollowButton(String friendID) {
    if(widget.userId == friendID) return Container();
    else if(userFollowingIDs.contains(friendID)) return showUnfollowButton(friendID);
    else return showFollowButton(friendID);
  }

  Widget showViewButton(String friendID) {
    return new Padding(
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
        child: SizedBox(
          height: 30.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: AppColors.voidBackground7,
            child: new Text('view page',
                style: new TextStyle(
                    fontSize: 15.0, color: AppColors.randomButtonText2)),
            onPressed: () => onViewPressed(context, friendID),
          ),
        )
    );
  }


  void onViewPressed(BuildContext context, String friendID) => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                UserProfile(userId: widget.userId, viewId: friendID)));

  void onUnfollowPressed(String friendID) async {
    await db.unfollowFriend(widget.userId, friendID);
    setState(() {
      loading = true;
      getAllLists();
    });
  }

  void onFollowPressed(String friendID) async {
    await db.followFriend(widget.userId, friendID);
    setState(() {
      loading = true;
      getAllLists();
    });
  }
  
}