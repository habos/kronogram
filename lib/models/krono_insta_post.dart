import 'package:flutter/material.dart';
import 'package:kronogram/models/insta_post_data.dart';
import 'package:kronogram/models/krono_post.dart';
import 'package:kronogram/models/sm_platform.dart';
import 'package:kronogram/widgets/instagram_post_view.dart';

/// KronoInstaPost wraps a [InstaPostData] object so that it
/// fulfills the [KronoPost] interface
class KronoInstaPost implements KronoPost {
  final InstaPostData _instaPost;

  /// Constructs a KronoInstaPost object given a [InstaPostData] object
  KronoInstaPost(this._instaPost);

  /// Returns a [InstagramPostView] Widget displaying the underlying Instagram
  /// post.
  @override
  Widget createPostWidget() {
    return InstagramPostView.fromInstaPost(_instaPost);
  }

  /// Returns a [DateTime] object representing the time this post
  /// was made.
  @override
  DateTime getCreationTime() {
    return _instaPost.getCreationTime();
  }

  /// Returns [SMPlatform.instagram] since this post was made on Instagram.
  @override
  SMPlatform getPlatform() {
    return SMPlatform.instagram;
  }

  @override
  int getPostID() {
    return _instaPost.getID();
  }

  @override
  Map<String, dynamic> toJson()  =>
      {
        'media' : _instaPost.getPostMedia(),
        'createdAt' : _instaPost.getCreationTime(),
        'caption' : _instaPost.getCaption(),
        'postId' : _instaPost.getID(),
        'isAlbum' : _instaPost.isAlbum()
      };

  static KronoInstaPost fromJson(Map<String, dynamic> json) {
    InstaPostData data = new InstaPostData();
    data.media = json['media'];
    data.createdAt = json['createdAt'];
    data.caption = json['caption'];
    data.id = json['postId'];
    return KronoInstaPost(data);
  }
}
