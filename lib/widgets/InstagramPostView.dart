import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kronogram/models/InstaPost.dart';

class InstagramPostView extends StatelessWidget {
  final String imgUrl;

  InstagramPostView.fromInstaPost(InstaPost instaPost)
      : imgUrl = instaPost.getPostMedia()[0].url;

  @override
  Widget build(BuildContext context) {
    return Image(image: CachedNetworkImageProvider(imgUrl));
  }
}
