import 'package:flutter/material.dart';
import 'package:kronogram/models/location.dart';
import 'package:kronogram/models/sm_platform.dart';

/// An interface that abstracts the idea of a post within Kronogram.
abstract class KronoPost {
  /// Returns a [Widget] that displays the post.
  Widget createPostWidget();

  /// Returns a [DateTime] object representing the time that this post
  /// was made.
  DateTime getCreationTime();

  /// Returns an [SMPlatform] enum value corresponding to the platform on which
  /// the original post was made.
  SMPlatform getPlatform();

  /// Returns the post ID
  int getPostID();

  /// Returns the location data associated with the post
  Location getLocation();

  /// Returns a map for easy encoding.
  Map<String, dynamic> toJson();
}
