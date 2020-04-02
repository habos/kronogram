import 'package:kronogram/models/insta_post_data.dart';
import 'package:kronogram/models/krono_fb_post.dart';
import 'package:kronogram/models/krono_insta_post.dart';
import 'package:kronogram/models/krono_tweet.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:kronogram/models/post.dart';
import 'package:tweet_ui/models/api/tweet.dart' as TweetUI;
import 'package:twitter_api/twitter_api.dart';

abstract class APIrequests {
  Future<List<KronoInstaPost>> requestInstaPosts(var userInfo);
  Future<List<KronoFacebookPost>> requestFbPosts(var userInfo);
  Future<List<KronoTweet>> requestTweets(var userInfo);
}

class APIcalls extends APIrequests {
  Future<List<KronoInstaPost>> requestInstaPosts(var userInfo) async {
    var posts = new List();

    final token = userInfo['token'];
    final graphResponse = await http.get(
        'https://graph.instagram.com/me?fields=media{id,caption,media_type,media_url,timestamp,children{media_type,media_url}}&access_token=$token');
    final jsonPostHistory = JSON.jsonDecode(graphResponse.body);
    for (var jsonPost in jsonPostHistory['media']['data']) {
      InstaPostData instaPost = new InstaPostData.fromJson(jsonPost);
      posts.add(new KronoInstaPost(instaPost));
    }

    return posts;
  }

  Future<List<KronoFacebookPost>> requestFbPosts(var userInfo) async {
    var posts = new List();

    final token = userInfo['token'];
    final graphResponse = await http.get(
        'https://graph.facebook.com/me/?fields=posts{id,created_time,name,message,place,attachments{media{image},type,subattachments}}&access_token=$token');
    final jsonPostHistory = JSON.jsonDecode(graphResponse.body);
    for (var jsonPost in jsonPostHistory['posts']['data']) {
      FacebookPostData fbPost =
          new FacebookPostData.fromJson(jsonPost, userInfo['userId']);
      posts.add(new KronoFacebookPost(fbPost));
    }

    return posts;
  }

  Future<List<KronoTweet>> requestTweets(var userInfo) async {
    var tweets = new List();

    final _twitterOauth = new twitterApi(
        consumerKey: 'JZScfVJ2TnkzVHy7lS7XHGU1z',
        consumerSecret: 'fk9BSlBe6mDnioJeoIc7thAQeODgnbEBZAJoBsuPVGYG8PmMQW',
        token: userInfo['token'],
        tokenSecret: userInfo['secret']);

    var twitterRequest = _twitterOauth
        .getTwitterRequest("GET", "statuses/user_timeline.json", options: {
      "screen_name": userInfo['username'],
    });

    var res = await twitterRequest;
    var tweetResponse = JSON.jsonDecode(res.body);
    for (var i = 0; i < tweetResponse.length; i++) {
      tweets.add(new KronoTweet(TweetUI.Tweet.fromJson(tweetResponse[i])));
    }

    return tweets;
  }
}
