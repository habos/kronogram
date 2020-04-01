import 'package:flutter/material.dart';
import 'package:kronogram/models/krono_post.dart';
import 'package:kronogram/models/sm_platform.dart';

/// Dummy class for UI testing purposes.
class KronoDummyPost implements KronoPost {
  /// Returns a blank, white [Container].
  @override
  Widget createPostWidget() {
    return Container(color: Colors.white);
  }

  /// Returns the current time.
  @override
  DateTime getCreationTime() {
    return DateTime.now();
  }

  /// Returns [SMPlatform.facebook].
  /// This value is arbitrary since this is just a dummy class.
  @override
  SMPlatform getPlatform() {
    return SMPlatform.facebook;
  }

  @override
  int getPostID() {
    return 1;
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'test' : 'test'
      };
}
