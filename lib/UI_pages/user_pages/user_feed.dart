import 'package:flutter/material.dart';
import 'package:kronogram/UI_pages/values/values.dart';
import 'package:kronogram/models/krono_fb_post.dart';
import 'package:kronogram/models/krono_insta_post.dart';
import 'package:kronogram/models/krono_post.dart';
import 'package:kronogram/models/krono_tweet.dart';
import 'package:kronogram/services/globals.dart';
import 'package:kronogram/widgets/post_view.dart';

class UserFeed extends StatefulWidget {
  UserFeed({Key key, this.userId})
    :super(key:key);

  final String userId;

  @override
  State<StatefulWidget> createState() {
    return _UserFeedState();
  }
}

class _UserFeedState extends State<UserFeed> {
  bool _loading = true;
//  List<KronoPost> feedPosts = List();
  List<Map<String, dynamic>> feedPosts = List();
  DateTime today = new DateTime.now();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void getPosts(var userID) async {
    String username = await db.getUsername(userID);
    Map instaUser = await db.getInstagramInfo(userID);
    List<KronoInstaPost> instaPosts = await APIcaller.requestInstaPosts(instaUser);
    if(instaPosts != null) {
      for(KronoInstaPost post in instaPosts) {
        DateTime postTime = post.getCreationTime().toLocal();
        if(postTime.month == today.month && postTime.day == today.day) {
          feedPosts.add({'post' : post, 'username' : username});
        }
      }
    }

    Map facebookUser = await db.getFacebookInfo(userID);
    List<KronoFacebookPost> posts = await APIcaller.requestFbPosts(facebookUser);
    if(posts != null) {
      for (KronoFacebookPost post in posts) {
        DateTime postTime = post.getCreationTime().toLocal();
        if (postTime.month == today.month && postTime.day == today.day) {
          feedPosts.add({'post': post, 'username': username});
        }
      }
    }

    Map twitterUser = await db.getTwitterInfo(userID);
    List<KronoTweet> tweets = await APIcaller.requestTweets(twitterUser);
    if(tweets != null) {
      for (KronoTweet tweet in tweets) {
        DateTime postTime = tweet.getCreationTime().toLocal();
        if (postTime.month == today.month && postTime.day == today.day) {
          feedPosts.add({'post': tweet, 'username': username});
        }
      }
    }

    feedPosts.sort((a, b) => a['post'].getCreationTime().toLocal().compareTo(b['post'].getCreationTime().toLocal()) * -1);
    setState(() {
      _loading = false;
    });
  }

  void getAllUsersPosts(String userID) async {
    //get user's posts
    await getPosts(userID);
    //get friends' posts
    List<String> friends = await db.getFollowingIDs(userID);
    for(String friend in friends) {
      getPosts(friend);
    }
  }

  @override
  void initState() {
    super.initState();
    getAllUsersPosts(widget.userId);
  }

  Widget progress() {
    if(_loading) {
      return new Container(
        child: new Stack(
          children: <Widget>[
            new Container(
              alignment: AlignmentDirectional.center,
              decoration: new BoxDecoration(
                color: Colors.white70,
              ),
              child: new Container(
                decoration: new BoxDecoration(
                    color: AppColors.voidBackground10,
                    borderRadius: new BorderRadius.circular(10.0)
                ),
                width: 300.0,
                height: 200.0,
                alignment: AlignmentDirectional.center,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Center(
                      child: new SizedBox(
                        height: 50.0,
                        width: 50.0,
                        child: new CircularProgressIndicator(
                          value: null,
                          strokeWidth: 7.0,
                          valueColor: new AlwaysStoppedAnimation<Color>(Colors
                              .white),
                        ),
                      ),
                    ),
                    new Container(
                      margin: const EdgeInsets.only(top: 25.0),
                      child: new Center(
                        child: new Text(
                          "loading...",
                          style: new TextStyle(
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
    else return Container();
  }

  Widget showPosts() {
    if(_loading) return Container();
    else {
      if (feedPosts.length == 0) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 5.0),
          color: AppColors.primaryBackground,
          child: Container(
            alignment: Alignment.center,
            decoration: new BoxDecoration(
              color: Colors.white70,
            ),
            child: Container(
              decoration: new BoxDecoration(
                  color: AppColors.voidBackground10,
                  borderRadius: new BorderRadius.circular(10.0)
              ),
              width: 300.0,
              height: 200.0,
              alignment: AlignmentDirectional.center,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    margin: const EdgeInsets.only(top: 25.0),
                    child: new Center(
                      child: new Text(
                        "There Are No Memories For Today 🙁",
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 15
                        ),
                      ),
                    ),
                  ),
                  new Container(
                    margin: const EdgeInsets.only(top: 25.0),
                    child: new Center(
                      child: new Text(
                        "Go Make Some New Ones!",
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        );
      }
      else {
        return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: feedPosts.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          (today
                              .difference(feedPosts[index]['post']
                              .getCreationTime().toLocal())
                              .inDays ~/ 365).toString() + ' years ago today',
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        Container(
                          height: 1,
                          width: 200,
                          color: Colors.black,
                          margin: const EdgeInsets.only(left: 10, right: 10),
                        )
                      ],
                    ),
                    postView(
                        feedPosts[index]['post'], feedPosts[index]['username'])
                  ],
                ),
              );
            }
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        showPosts(),
        progress()
      ],
    );
  }

}

//class userFeed extends StatelessWidget {
//  userFeed({@required this.today}) : assert(today != null);
//
//  bool today;
//  List<generalPost> postsList = userTestPost().getpostlists(15);
//  String postDate;
//
//  @override
//  Widget build(BuildContext context) {
//    checkDate(today);
//    return Container(
//      child: ListView.separated(
//        padding: const EdgeInsets.all(8),
//        itemCount: postsList.length,
//        itemBuilder: (BuildContext context, int index) {
//          return Container(
//            child:
//                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//              Row(
//                //crossAxisAlignment: CrossAxisAlignment.stretch,
//                children: [
//                  Text(
//                    postDate,
//                    textAlign: TextAlign.left,
//                    style: TextStyle(
//                      color: Color.fromARGB(255, 0, 0, 0),
//                      fontWeight: FontWeight.w400,
//                      fontSize: 14,
//                    ),
//                  ),
//                  Container(
//                    height: 1,
//                    width: 260,
//                    color: Colors.black,
//                    margin: const EdgeInsets.only(left: 10.0, right: 10.0),
//                  ),
//                ],
//              ),
//              testPost(
//                plat: postsList[index].platform,
//                username: postsList[index].userPosted,
//                action: postsList[index].action,
//              )
//            ]),
//          );
//        },
//        separatorBuilder: (BuildContext context, int index) => Divider(
//          color: Colors.black,
//        ),
//
//        //Divider(color: Colors.black,),
//      ),
//    );
//  }
//
//  void checkDate(bool today) {
//    if (today) {
//      postDate = "X years ago today";
//    } else {
//      postDate = "DATE:";
//    }
//  }
//
//  Widget showPrimaryButton() {
//    return new Padding(
//        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
//        child: SizedBox(
//          height: 40.0,
//          child: new RaisedButton(
//            elevation: 5.0,
//            shape: new RoundedRectangleBorder(
//                borderRadius: new BorderRadius.circular(30.0)),
//            color: AppColors.randomButton2,
//            child: new Text('Show Timeline',
//                style: new TextStyle(fontSize: 20.0, color: AppColors.randomButtonText2)),
//            onPressed: null,
//          ),
//        ));
//  }
//}
