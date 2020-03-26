import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kronogram/models/media.dart';
import 'package:kronogram/models/post.dart';
import 'package:kronogram/styles/text_styles.dart';

class FacebookPostView extends StatelessWidget {
  final List<FacebookMedia> _media;
  final String _caption;
  final bool _isAlbum;

  // TODO: implement constructor
  FacebookPostView.fromFacebookPost(FacebookPostData fbPost)
    : _media = fbPost.getPostMedia(),
      _caption = fbPost.getCaption(),
      _isAlbum = fbPost.isAlbum();

  Widget singleImage(FacebookMedia media) {
    return CachedNetworkImage(
      imageUrl: media.getUrl(),
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context,url,error) => Icon(Icons.error),
    );
  }

  Widget postView() {
    return _media.length == 0 ? Container() :
        singleImage(_media[0]);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          postView(),
          Container(
            width: MediaQuery.of(context).size.width,
            child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                text: _caption,
                style: defaultFBCaptionTextStyle
              ),
            ),
          )
        ],
      ),
    );
  }

}