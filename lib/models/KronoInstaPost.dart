import 'package:kronogram/models/media.dart';
import 'package:kronogram/utils/DateUtils.dart';

class KronoInstaPost {
  final int id;
  final String caption;
  final DateTime createdAt;
  List<InstaMedia> media = new List();

  KronoInstaPost.fromJson(Map<String, dynamic> json)
      : id = int.parse(json['id']),
        caption = json['caption'],
        createdAt = parseInstagramCreationTime(json['timestamp']) {
    String type = json['media_type'];
    if (type != 'CAROUSEL_ALBUM') {
      this.media.add(new InstaMedia(type, json['media_url']));
    }
  }

  void addMedia(String type, String url) {
    this.media.add(new InstaMedia(type, url));
  }
}
