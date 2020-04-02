import 'package:kronogram/models/media.dart';
import 'package:kronogram/utils/date_utils.dart';

class InstaPostData {
  int id;
  String caption;
  DateTime createdAt;
  List<InstaMedia> media = new List();

  InstaPostData();

  InstaPostData.fromJson(Map<String, dynamic> json)
      : id = int.parse(json['id']),
        caption = json['caption'],
        createdAt = parseInstagramCreationTime(json['timestamp']) {
    String type = json['media_type'];
    if (type == 'CAROUSEL_ALBUM') {
      var children = json['children']['data'];
      for (var child in children) {
        media.add(new InstaMedia(child['media_type'], child['media_url']));
      }
    } else {
      media.add(new InstaMedia(type, json['media_url']));
    }
  }

  DateTime getCreationTime() {
    return createdAt;
  }

  void addMedia(String type, String url) {
    media.add(new InstaMedia(type, url));
  }

  int getID() {
    return id;
  }

  String getCaption() {
    return caption;
  }

  List<InstaMedia> getPostMedia() {
    return media;
  }

  bool isAlbum() {
    return media.length > 1;
  }
}
