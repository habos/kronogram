import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kronogram/models/krono_fb_post.dart';
import 'package:kronogram/models/krono_insta_post.dart';
import 'package:kronogram/models/krono_post.dart';
import 'package:kronogram/models/krono_tweet.dart';
import 'package:kronogram/models/sm_platform.dart';
import 'package:kronogram/services/globals.dart';

Future<void> buildAndStoreTimeline(String userID) async {
  storeInstagramPostsInFirestore(userID);
  storeTweetsInFirestore(userID);
  storeFacebookPostsInFirestore(userID);
}

Future<List<KronoPost>> reconstructTimeline(String userID) async {
  List<KronoPost> timeline = new List();
  List<DocumentSnapshot> summary = new List();
  db
      .getUserTimelineSummary(userID)
      .orderBy('creationTime', descending: true)
      .snapshots()
      .listen((data) => data.documents.forEach((doc) => summary.add(doc)));

  for (DocumentSnapshot snap in summary) {
    String platform = snap.data['platform'];
    int postID = snap.data['postID'];
    DocumentSnapshot kronoPostData;
    KronoPost newPost;
    if (platform == "facebook") {
      kronoPostData = await db.getFacebookPost(postID);
      var JSONmap = kronoPostData.data;
      newPost = KronoFacebookPost.fromJson(JSONmap);
    } else if (platform == "instagram") {
      kronoPostData = await db.getIGPost(postID);
      var JSONmap = kronoPostData.data;
      newPost = KronoInstaPost.fromJson(JSONmap);
    } else {
      kronoPostData = await db.getTweet(postID);
      var JSONmap = kronoPostData.data;
      newPost = KronoTweet.fromJson(JSONmap);
    }
    timeline.add(newPost);
  }
  return timeline;
}

Future<void> storeInstagramPostsInFirestore(String userID) async {
  Map instaUser = await db.getInstagramInfo(userID);
  List<KronoInstaPost> instaPosts =
      await APIcaller.requestInstaPosts(instaUser);
  for (KronoInstaPost post in instaPosts) {
    db.addToUserTimelineSummary(userID, post.getPostID(),
        post.getCreationTime(), SMPlatform.instagram.toString());
    db.addToInstagramPosts(post);
  }
}

Future<void> storeTweetsInFirestore(String userID) async {
  Map twitterUser = await db.getTwitterInfo(userID);
  List<KronoTweet> tweets = await APIcaller.requestTweets(twitterUser);
  for (KronoTweet tweet in tweets) {
    db.addToUserTimelineSummary(userID, tweet.getPostID(),
        tweet.getCreationTime(), SMPlatform.twitter.toString());
    db.addToTwitterPosts(tweet);
  }
}

Future<void> storeFacebookPostsInFirestore(String userID) async {
  Map facebookUser = await db.getFacebookInfo(userID);
  List<KronoFacebookPost> posts = await APIcaller.requestFbPosts(facebookUser);
  for (KronoFacebookPost post in posts) {
    db.addToUserTimelineSummary(userID, post.getPostID(),
        post.getCreationTime(), SMPlatform.facebook.toString());
    db.addToFacebookPosts(post);
  }
}
