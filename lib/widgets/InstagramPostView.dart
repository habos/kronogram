import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kronogram/models/InstaPost.dart';
import 'package:kronogram/styles/TextStyles.dart';

class InstagramPostView extends StatelessWidget {
  final String imgUrl;
  final String caption;

  InstagramPostView.fromInstaPost(InstaPostData instaPost)
      : imgUrl = instaPost.getPostMedia()[0].url,
        caption = instaPost.getCaption();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Image(image: CachedNetworkImageProvider(imgUrl)),
            Container(
              width: MediaQuery.of(context).size.width,
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  text: caption,
                  style: defaultTweetTextStyle
                )
              )
            )
          ],
        )
    );
  }
}
