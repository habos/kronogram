import 'package:flutter/cupertino.dart';
import 'package:kronogram/models/insta_post_data.dart';
import 'package:kronogram/models/krono_fb_post.dart';
import 'package:kronogram/models/krono_insta_post.dart';
import 'package:kronogram/models/krono_tweet.dart';
import 'package:http/http.dart' as http;
import 'package:kronogram/models/location.dart';
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
    if (userInfo == null) return null;

    var posts = new List<KronoInstaPost>();

    final token = userInfo['token'];
    final graphResponse = await http.get(
        'https://graph.instagram.com/me?fields=media{id,caption,media_type,media_url,timestamp,children{media_type,media_url}}&access_token=$token');
    if(graphResponse.statusCode != 200) return null;
    final jsonPostHistory = JSON.jsonDecode(graphResponse.body);
    for (var jsonPost in jsonPostHistory['media']['data']) {
      InstaPostData instaPost = new InstaPostData.fromJson(jsonPost);
      posts.add(new KronoInstaPost(instaPost));
    }

    return posts;
  }

  Future<List<KronoFacebookPost>> requestFbPosts(var userInfo) async {
    var posts = new List<KronoFacebookPost>();

    final token = userInfo['token'];
    final graphResponse = await http.get(
        'https://graph.facebook.com/me/?fields=posts{id,created_time,name,message,place{location{latitude,longitude}},attachments{media{image},type,subattachments}}&access_token=$token');
    if(graphResponse.statusCode != 200) return null;
    final jsonPostHistory = JSON.jsonDecode(graphResponse.body);
    for (var jsonPost in jsonPostHistory['posts']['data']) {
      FacebookPostData fbPost =
          new FacebookPostData.fromJson(jsonPost, userInfo['userId']);
      FacebookLocationData location = jsonPost['place'] == null ? null : FacebookLocationData.fromJson(jsonPost['place']['location']);

      posts.add(new KronoFacebookPost(fbPost,location));
    }

    return posts;
  }

  Future<List<KronoTweet>> requestTweets(var userInfo) async {
    var tweets = new List<KronoTweet>();

    final _twitterOauth = new twitterApi(
        consumerKey: 'JZScfVJ2TnkzVHy7lS7XHGU1z',
        consumerSecret: 'fk9BSlBe6mDnioJeoIc7thAQeODgnbEBZAJoBsuPVGYG8PmMQW',
        token: userInfo['token'],
        tokenSecret: userInfo['secret']);

    var twitterRequest = _twitterOauth.getTwitterRequest("GET", "statuses/user_timeline.json",
        options: {
          "screen_name": userInfo['username'],
          "count" : '100',
        });

    var res = await twitterRequest;
    if(res.statusCode != 200) {return null;}
    var tweetResponse = JSON.jsonDecode(res.body);
    for (var i = 0; i < tweetResponse.length; i++) {
      TwitterLocationData location;
      if(tweetResponse[i]['coordinates'] != null || tweetResponse[i]['place'] != null) location = new TwitterLocationData.fromJson(tweetResponse[i]);
      else location = null;
      tweets.add(new KronoTweet(TweetUI.Tweet.fromJson(tweetResponse[i]), location));
    }

    return tweets;
  }



  /////////////////////////////////////////////////////////////
//for when able to store in database and implement paging/cursoring
  ///called when a user logs in for the first time, this will return all current facebook posts from the user
  Future<List<KronoFacebookPost>> requestFirstTimeFbPosts(var userInfo) async {
    var posts = new List<KronoFacebookPost>();

    final token = userInfo['token'];
    final graphResponse = await http.get(
        'https://graph.facebook.com/me/?fields=posts{id,created_time,name,message,place,attachments{media{image},type,subattachments}}&access_token=$token');
    if(graphResponse.statusCode != 200) return null;
    final jsonPostHistory = JSON.jsonDecode(graphResponse.body);
    for (var jsonPost in jsonPostHistory['posts']['data']) {
      FacebookPostData fbPost =
      new FacebookPostData.fromJson(jsonPost, userInfo['userId']);
      FacebookLocationData location = jsonPost['place'] == null ? null : FacebookLocationData.fromJson(jsonPost['place']['location']);

      posts.add(new KronoFacebookPost(fbPost,location));
    }

    var fbNext = jsonPostHistory['posts']['paging']['next'];

    while(fbNext != null) {
      var res = await http.get(fbNext);
      var json = JSON.jsonDecode(res.body);
      for(var jsonPost in json['posts']['data']) {
        FacebookPostData fbPost = new FacebookPostData.fromJson(jsonPost, userInfo['userId']);
        FacebookLocationData location = jsonPost['place'] == null ? null : FacebookLocationData.fromJson(jsonPost['place']['location']);

        posts.add(new KronoFacebookPost(fbPost,location));
      }

      fbNext = jsonPostHistory['posts']['paging']['next'];
    }

    //store in database to base new calls off of
    var timestamp = new DateTime.now().toUtc().millisecondsSinceEpoch.toString();

    return posts;
  }

/// called when a user logs in after first time, looks for any new Facebook posts since the last login
  Future<List<KronoFacebookPost>> requestNewFbPosts(var userInfo) async {
    var posts = new List<KronoFacebookPost>();
    //store in db for next new call
    var currentTimestamp = new DateTime.now().toUtc().millisecondsSinceEpoch.toString();
    //pull from userInfo in database
    var prevTimestamp = userInfo['timestamp'];

    final token = userInfo['token'];
    final graphResponse = await http.get(
      'https://graph.facebook.com/me/?fields=posts{id,created_time,name,message,place,attachments{media{image}, type, subattachments}}'
          '&access_token=$token&since=$prevTimestamp&until=$currentTimestamp'
    );
    if(graphResponse.statusCode != 200) return null;
    final jsonPostHistory = JSON.jsonDecode(graphResponse.body);
    for(var jsonPost in jsonPostHistory['posts']['data']) {
      FacebookPostData fbPost =
      new FacebookPostData.fromJson(jsonPost, userInfo['userId']);
      FacebookLocationData location = jsonPost['place'] == null ? null : FacebookLocationData.fromJson(jsonPost['place']['location']);

      posts.add(new KronoFacebookPost(fbPost,location));
    }

    var fbNext = jsonPostHistory['posts']['paging']['next'];

    while(fbNext != null) {
      var res = await http.get(fbNext);
      var json = JSON.jsonDecode(res.body);
      for(var jsonPost in json['posts']['data']) {
        FacebookPostData fbPost = new FacebookPostData.fromJson(jsonPost, userInfo['userId']);
        FacebookLocationData location = jsonPost['place'] == null ? null : FacebookLocationData.fromJson(jsonPost['place']['location']);

        posts.add(new KronoFacebookPost(fbPost,location));
      }

      fbNext = jsonPostHistory['posts']['paging']['next'];
    }

    return posts;
  }

/// retrieves all of a users current tweets upon first login
  Future<List<KronoTweet>> requestFirstTimeTweets(var userInfo) async {
    var tweets = new List<KronoTweet>();

    final _twitterOauth = new twitterApi(
        consumerKey: 'JZScfVJ2TnkzVHy7lS7XHGU1z',
        consumerSecret: 'fk9BSlBe6mDnioJeoIc7thAQeODgnbEBZAJoBsuPVGYG8PmMQW',
        token: userInfo['token'],
        tokenSecret: userInfo['secret']);

    var twitterRequest = _twitterOauth.getTwitterRequest("GET", "statuses/user_timeline.json",
        options: {
          "screen_name": userInfo['username'],
          "count" : '200',
        });

    List<KronoTweet> firstTweets= await _callTweets(twitterRequest,0);
    tweets.addAll(firstTweets);

    //to store in db to get new tweets
    String twitterSinceID = firstTweets[0].getPostID().toString();

    List<KronoTweet> nextTweets = firstTweets;

    while(nextTweets.length == 200) {
      String twitterMaxID = nextTweets[nextTweets.length - 1].getPostID().toString();

      twitterRequest =
          _twitterOauth.getTwitterRequest("GET", "statuses/user_timeline.json",
              options: {
                "screen_name": userInfo['username'],
                "count": '200',
                "max_id": twitterMaxID
              });

      nextTweets = await _callTweets(twitterRequest, 1);
      tweets.addAll(nextTweets);
    }

    return tweets;
  }

  /// retrieves all of a users new tweets since last login
  Future<List<KronoTweet>> requestNewTweets(var userInfo) async {
    var tweets = new List<KronoTweet>();

    String sinceID = userInfo['sinceID'];

    final _twitterOauth = new twitterApi(
        consumerKey: 'JZScfVJ2TnkzVHy7lS7XHGU1z',
        consumerSecret: 'fk9BSlBe6mDnioJeoIc7thAQeODgnbEBZAJoBsuPVGYG8PmMQW',
        token: userInfo['token'],
        tokenSecret: userInfo['secret']);

    var twitterRequest = _twitterOauth.getTwitterRequest("GET", "statuses/user_timeline.json",
        options: {
          "screen_name": userInfo['username'],
          "count" : '200',
          "since_id" : sinceID
        });

    List<KronoTweet> firstTweets= await _callTweets(twitterRequest,0);
    tweets.addAll(firstTweets);

    //to store in db to get new tweets
    String twitterSinceID = firstTweets[0].getPostID().toString();

    List<KronoTweet> nextTweets = firstTweets;

    while(nextTweets.length == 200) {
      String twitterMaxID = nextTweets[nextTweets.length - 1].getPostID().toString();

      twitterRequest =
          _twitterOauth.getTwitterRequest("GET", "statuses/user_timeline.json",
              options: {
                "screen_name": userInfo['username'],
                "count": '200',
                "since_id": sinceID,
                "max_id" : twitterMaxID
              });

      nextTweets = await _callTweets(twitterRequest, 0);
      tweets.addAll(nextTweets);
    }

    return tweets;
  }

/// helper function to return a list of tweets for a certain api call
  Future<List<KronoTweet>> _callTweets(var twitterRequest, int start) async {
    List<KronoTweet> tweets = new List();

    var res = await twitterRequest;
    if(res.statusCode != 200) return null;
    var tweetResponse = JSON.jsonDecode(res.body);
    for (var i = start; i < tweetResponse.length; i++) {
      TwitterLocationData location;
      if(tweetResponse[i]['coordinates'] != null || tweetResponse[i]['place'] != null) location = new TwitterLocationData.fromJson(tweetResponse[i]);
      else location = null;
      tweets.add(new KronoTweet(TweetUI.Tweet.fromJson(tweetResponse[i]), location));
    }

    return tweets;
  }
}

