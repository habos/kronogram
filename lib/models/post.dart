import 'package:kronogram/models/media.dart';

class FacebookPostData {
  String userId;
  DateTime createdAt;
  String caption;
  String id;
  String title;
  List<FacebookMedia> media = new List();

  FacebookPostData();

  FacebookPostData.fromJson(Map<String, dynamic> json, String userId) {
    this.userId = userId;
    this.id = json['id'];
    this.caption = json['message'];
    this.title = json[
        'name']; //might be null if there is no title; mainly for like when photos are added to album or cover photo updated
    DateTime date = DateTime.parse(json['created_time']);
    this.createdAt = new DateTime.utc(
        date.year, date.month, date.day, date.hour, date.minute, date.second);

    if (this.caption == null) this.caption = this.title;

    if (json['attachments'] != null) {
      var attachments = json['attachments']['data'];
      for (var x in attachments) {
        //goes through array of [attachments][data]
        if (x['type'] == 'album') {
          var subAttachments = x['subattachments']['data'];
          for (var y in subAttachments) {
            //goes through array of ...[subattachments][data]
            if (y['media'] != null) {
              this.media.add(new FacebookMedia.fromJson(y));
            }
          }
        } else if (x['media'] != null) {
          //if single media like cover photo
          this.media.add(new FacebookMedia.fromJson(x));
        }
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
