import 'package:kronogram/models/media.dart';
import 'package:kronogram/utils/date_utils.dart';

class InstaPostData {
  final int _id;
  final String _caption;
  final DateTime _createdAt;
  List<InstaMedia> _media = new List();

  InstaPostData.fromJson(Map<String, dynamic> json)
      : _id = int.parse(json['id']),
        _caption = json['caption'],
        _createdAt = parseInstagramCreationTime(json['timestamp']) {
    String type = json['media_type'];
    if (type=='CAROUSEL_ALBUM') {
      var children = json['children']['data'];
      for(var child in children) {
        _media.add(new InstaMedia(child['media_type'], child['media_url']));
      }
    }
    else {
      _media.add(new InstaMedia(type, json['media_url']));
    }
  }

  DateTime getCreationTime() {
    return _createdAt;
  }

  void addMedia(String type, String url) {
    _media.add(new InstaMedia(type, url));
  }

  int getID() {
    return _id;
  }

  String getCaption() {
    return _caption;
  }

  List<InstaMedia> getPostMedia() {
    return _media;
  }

  bool isAlbum() {
    return _media.length > 1;
  }
}
