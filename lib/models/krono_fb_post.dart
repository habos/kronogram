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
}