import 'package:flutter/material.dart';
import 'package:kronogram/models/SMPlatform.dart';

/// An interface that abstracts the idea of a post within Kronogram.
abstract class KronoPost {
  /// Returns a [Widget] that displays the post.
  Widget createPostWidget();

  /// Returns a [DateTime] object representing the time that this post
  /// was made.
  DateTime getCreationTime();

  /// Returns an [SMPlatform] value corresponding to the platform on which
  /// the original post was made.
  SMPlatform getPlatform();
}
