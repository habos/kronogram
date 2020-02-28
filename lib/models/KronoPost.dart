import 'package:flutter/material.dart';

abstract class KronoPost {

  Widget createPostWidget();
  DateTime getCreationTime();
}