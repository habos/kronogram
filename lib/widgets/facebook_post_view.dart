import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kronogram/models/media.dart';
import 'package:kronogram/models/post.dart';
import 'package:kronogram/styles/text_styles.dart';
import 'package:video_player/video_player.dart';

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
      imageUrl: media.url,
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }

  VideoPlayerController getVideoPlayerController(FacebookMedia media) {
    var controller = VideoPlayerController.network(media.url);
    controller.initialize();
    return controller;
  }

  Widget albumCarousel() {
    return CarouselSlider(
      height: 400.0,
      items: _media.map((med) {
        if (med.type == "photo" ||
            med.type == "cover_photo" ||
            med.type == "profile_media") {
          return singleImage(med);
        }
        VideoPlayerController controller = getVideoPlayerController(med);
        return AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: VideoPlayer(controller),
        );
      }).toList(),
      enableInfiniteScroll: false,
    );
  }

  Widget postView() {
    return _isAlbum
        ? albumCarousel()
        : _media.length == 0 ? Container() : singleImage(_media[0]);
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
              text: TextSpan(text: _caption, style: defaultFBCaptionTextStyle),
            ),
          )
        ],
      ),
    );
  }
}
