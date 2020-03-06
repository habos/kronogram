import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kronogram/models/insta_post_data.dart';
import 'package:kronogram/models/media.dart';
import 'package:kronogram/styles/text_styles.dart';
import 'package:video_player/video_player.dart';

class InstagramPostView extends StatelessWidget {
  final List<InstaMedia> _media;
  final String _caption;
  final bool _isAlbum;

  InstagramPostView.fromInstaPost(InstaPostData instaPost)
      : _media = instaPost.getPostMedia(),
        _caption = instaPost.getCaption(),
        _isAlbum = instaPost.isAlbum();

  VideoPlayerController getVideoPlayerController(InstaMedia media) {
    var controller = VideoPlayerController.network(media.url);
    controller.initialize();
    return controller;
  }
  
  Widget postView() {
    return _isAlbum ? albumCarousel() :
      _media.length == 0 ? Container() :
          Image(image: CachedNetworkImageProvider(_media[0].url));
  }

  Widget albumCarousel() {
    return CarouselSlider(
      height: 400.0,
      items: _media.map((med) {
        if (med.type == "IMAGE") {
          return Image(image: CachedNetworkImageProvider(med.url));
        }
        VideoPlayerController controller = getVideoPlayerController(med);
        return AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: VideoPlayer(controller)
        );
      }).toList(),
      enableInfiniteScroll: false,
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  style: defaultIGCaptionTextStyle
                )
              )
            )
          ],
        )
    );
  }
}
