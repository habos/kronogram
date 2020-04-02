import 'package:kronogram/models/media.dart';
import 'package:kronogram/models/location.dart';

class Post {
  String userId;
  DateTime createdAt;
  String caption;
  String id;
//  List<Media> media = new List(); //photo, video, animated_gif
}

class Tweet extends Post {

  String screenname;
  TwitterLocation location; //can be null
  List links = new List();  //attached urls
  List<TwitterMedia> media = new List();


  Tweet.fromJson(Map<String, dynamic> json, String userId) {
    this.userId = userId;
    id = json['id_str'];
    String dateStr = _parseDate(json['created_at']);
    DateTime date = DateTime.parse(dateStr);
    this.createdAt = new DateTime.utc(date.year,date.month,date.day,date.hour,date.minute,date.second);
    //FIXME
    if (json['truncated']==true) {
      this.caption = json['extended_tweet']['full_text'];
    }  //tweet of 141-280 characters
    else {
      this.caption = json['text'];
    }
    this.caption = json['text'];
    this.screenname = json['user']['screen_name'];
    if (json['place'] == null) this.location = null;
    else this.location=new TwitterLocation.fromJson(json['place']);   //needs to be tested
    //FIXME
    if (json['extended_entities'] == null || json['extended_entities']['media']==null) this.media = null;   //looks for media to parse, sets to null if none
    else {  //need to test else
      for (var m in json['extended_entities']['media']) {
        this.media.add(new TwitterMedia.fromJson(m));
      }
    }
    for (var i=0; i<json['entities']['urls'].length; i++) {
      this.links.add(json['entities']['urls'][i]['url']);
    }
    }

//TODO: write Tweet Object back to into json
//  Map<String,dynamic> toJson() =>
//      {
//
//
//      };

  String _parseDate(String date) {
    List dateList = date.split(" ");
    var year = dateList[5];
    var day = dateList[2];
    var time = dateList[3];
    var monthStr = dateList[1];
    var month;
    switch(monthStr) {
      case 'Jan' : month = '01'; break;
      case 'Feb' : month = '02'; break;
      case 'Mar' : month = '03'; break;
      case 'Apr' : month = '04'; break;
      case 'May' : month = '05'; break;
      case 'Jun' : month = '06'; break;
      case 'Jul' : month = '07'; break;
      case 'Aug' : month = '08'; break;
      case 'Sep' : month = '09'; break;
      case 'Oct' : month = '10'; break;
      case 'Nov' : month = '11'; break;
      case 'Dec' : month = '12'; break;
      default: month = '1'; break;
    }
    String dateStr = year+'-'+month+'-'+day+' '+time;
    return dateStr;

  }

  List<TwitterMedia> getMedia() {
    return media;
  }

  bool hasSubTweet() {
    return false;
  }

}

//Should it just be it's own tweet but with retweeted username added, etc. ?
class ReTweet extends Tweet {
  Tweet subTweet;

  ReTweet.fromJson(Map<String, dynamic> json, String userId) : super.fromJson(json, userId) {
    if(json['retweeted_status']['quoted_status'] != null) subTweet = new QuoteTweet.fromJson(json, userId);
    else subTweet = new Tweet.fromJson(json['retweeted_status'], userId);
  }

  List<TwitterMedia> getMedia() {
    return subTweet.media;
  }

  bool hasSubTweet() {
    return true;
  }
}

class QuoteTweet extends Tweet {
  Tweet subTweet;

  QuoteTweet.fromJson(Map<String,dynamic> json, String userId) : super.fromJson(json, userId) {
    if(json['quoted_status']['quoted_status'] != null) subTweet = new QuoteTweet.fromJson(json, userId);
    subTweet = new Tweet.fromJson(json['quoted_status'], userId);
  }

  List<TwitterMedia> getMedia() {
    return media + subTweet.media;
  }

  bool hasSubTweet() {
    return true;
  }
}

class InstaPost extends Post {
  List<InstaMedia> media = new List();

  InstaPost.fromJson(Map<String,dynamic> json) {
    this.id = json['id'];
    this.caption = json['caption'];
    DateTime date = DateTime.parse(json['timestamp']);
    this.createdAt = new DateTime.utc(date.year,date.month,date.day,date.hour,date.minute,date.second);
    String type = json['media_type'];
    if (type=='CAROUSEL_ALBUM') {
      var children = json['children']['data'];
      for(var child in children) {
        this.media.add(new InstaMedia(child['media_type'], child['media_url']));
      }
    }
    else {
      this.media.add(new InstaMedia(type, json['media_url']));
    }
  }

  void addMedia(String type, String url) {
    this.media.add(new InstaMedia(type, url));
  }
}

class FacebookPostData extends Post {
  String title;
  List<FacebookMedia> media = new List();

  FacebookPostData();

  FacebookPostData.fromJson(Map<String,dynamic> json, String userId) {
    this.userId = userId;
    this.id = json['id'];
    this.caption = json['message'];
    this.title = json['name'];  //might be null if there is no title; mainly for like when photos are added to album or cover photo updated
    DateTime date = DateTime.parse(json['created_time']);
    this.createdAt = new DateTime.utc(date.year,date.month,date.day,date.hour,date.minute,date.second);

    if (this.caption == null) this.caption = this.title;

    var attachments = json['attachments']['data'];
    for(var x in attachments) {   //goes through array of [attachments][data]
      if(x['type'] == 'album') {
          var subAttachments = x['subattachments']['data'];
          for(var y in subAttachments) {  //goes through array of ...[subattachments][data]
            if (y['media'] != null) {
              this.media.add(new FacebookMedia.fromJson(y));
            }
          }
      }
      else if (x['media'] != null){ //if single media like cover photo
          this.media.add(new FacebookMedia.fromJson(x));
      }
    }
  }

  String getCaption() {
    return this.caption;
  }

  String getUserId() {
    return this.userId;
  }

  String getTitle() {
    return title;
  }

  DateTime getCreationTime() {
    return this.createdAt;
  }

  String getID() {
    return this.id;
  }

  List<FacebookMedia> getPostMedia() {
    return media;
  }

  bool isAlbum() {
    return media.length > 1;
  }
}