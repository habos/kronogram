import 'package:kronogram/models/media.dart';
import 'package:kronogram/utils/DateUtils.dart';

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
    if (type != 'CAROUSEL_ALBUM') {
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
}
