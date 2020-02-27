import 'package:flutter/material.dart';
import 'package:kronogram/models/KronoPost.dart';

// Dummy class for UI testing purposes.
// createPostWidget returns a white, empty window.

class KronoDummyPost extends KronoPost {

  @override
  Widget createPostWidget() {
    return Container(
      color: Colors.white
    );
  }
}