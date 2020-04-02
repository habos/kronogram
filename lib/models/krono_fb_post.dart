import 'package:flutter/material.dart';
import 'package:kronogram/models/krono_post.dart';
import 'package:kronogram/models/sm_platform.dart';
import 'package:kronogram/models/post.dart';
import 'package:kronogram/widgets/facebook_post_view.dart';

class KronoFacebookPost implements KronoPost {
  final FacebookPostData _fbPostData;

  KronoFacebookPost(this._fbPostData);

  @override
  Widget createPostWidget() {
    return FacebookPostView.fromFacebookPost(_fbPostData);
  }

  @override
  DateTime getCreationTime() {
    return _fbPostData.createdAt;
  }

  @override
  SMPlatform getPlatform() {
    return SMPlatform.facebook;
  }

  @override
  int getPostID() {
    return int.parse(_fbPostData.id);
  }

  String userId;
  DateTime createdAt;
  String caption;
  String id;

  @override
  Map<String, dynamic> toJson() =>
      {
        'userId' : _fbPostData.getUserId(),
        'createdAt' : _fbPostData.getCreationTime(),
        'caption' : _fbPostData.getCaption(),
        'postId' : _fbPostData.getID(),
        'title' : _fbPostData.getTitle(),
        'media' : _fbPostData.getPostMedia()
      };

  static KronoFacebookPost fromJson(Map<String, dynamic> json) {
    FacebookPostData data = new FacebookPostData();
    data.userId = json['userId'];
    data.createdAt = json['createdAt'];
    data.caption = json['caption'];
    data.id = json['postId'];
    data.title = json['title'];
    data.media = json['media'];
    return KronoFacebookPost(data);
  }
}