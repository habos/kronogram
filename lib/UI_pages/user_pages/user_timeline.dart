import 'package:flutter/material.dart';
import 'package:kronogram/models/krono_fb_post.dart';
import 'package:kronogram/models/krono_insta_post.dart';
import 'package:kronogram/models/krono_post.dart';
import 'package:kronogram/models/krono_tweet.dart';
import 'package:kronogram/models/sm_platform.dart';
import 'package:kronogram/services/globals.dart';
import 'package:kronogram/widgets/post_view.dart';

class Timeline extends StatefulWidget{
  Timeline({Key key, this.userId})
      :super(key:key);

  final String userId;

  @override
  State<StatefulWidget> createState(){
    return _TimelineState();
  }
}

class _TimelineState extends State<Timeline>{
  List<KronoPost> timelinePosts = List();

  void nickMethod() async{
    Map instaUser = await db.getInstagramInfo(widget.userId);
    List<KronoInstaPost> instaPosts = await APIcaller.requestInstaPosts(instaUser);
    if (instaPosts != null) {
      for (KronoInstaPost post in instaPosts) {
        timelinePosts.add(post);
      }
    }

    Map twitterUser = await db.getTwitterInfo(widget.userId);
    List<KronoTweet> tweets = await APIcaller.requestTweets(twitterUser);
    for (KronoTweet tweet in tweets) {
      timelinePosts.add(tweet);
    }

    Map facebookUser = await db.getFacebookInfo(widget.userId);
    List<KronoFacebookPost> posts = await APIcaller.requestFbPosts(facebookUser);
    for (KronoFacebookPost post in posts) {
      timelinePosts.add(post);
    }

    timelinePosts.sort((a, b) => a.getCreationTime().compareTo(b.getCreationTime()) * -1);
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.userId);
    nickMethod();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: timelinePosts.length,
        itemBuilder: (BuildContext context, int index) {
          return postView(timelinePosts[index]);
        }
    );

  }
}



class PlaceholderWidget extends StatelessWidget {
  final Color color;

  PlaceholderWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}
