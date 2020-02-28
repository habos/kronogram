import 'package:flutter/material.dart';
import 'package:kronogram/models/InstaPost.dart';
import 'package:kronogram/models/KronoPost.dart';
import 'package:kronogram/models/SMPlatform.dart';
import 'package:kronogram/widgets/InstagramPostView.dart';

/// KronoInstaPost wraps a [InstaPost] object so that it
/// fulfills the [KronoPost] interface
class KronoInstaPost implements KronoPost {
  final InstaPost _instaPost;

  /// Constructs a KronoInstaPost object given a [InstaPost] object
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
}
