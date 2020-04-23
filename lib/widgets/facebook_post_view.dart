import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kronogram/UI_pages/values/colors.dart';
import 'package:kronogram/UI_pages/values/radii.dart';
import 'package:kronogram/models/media.dart';
import 'package:kronogram/models/post.dart';
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
      padding: EdgeInsets.fromLTRB(3, 3, 3, 3),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
          color: AppColors.primaryBackground,
        ),
      child: Column(
        children: <Widget>[
          postView(),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              "$_caption",
              textAlign: TextAlign.start,
            ),
          )
        ],
      )
    );
  }
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return Container(
//      margin: EdgeInsets.only(left: 10, right: 10),
//      decoration: BoxDecoration(
//        color: AppColors.primaryBackground,
//        borderRadius: Radii.k10pxRadius,
//      ),
//      child: Column(
//        children: [ Row(
//          mainAxisAlignment: MainAxisAlignment.center,
//          crossAxisAlignment: CrossAxisAlignment.center,
//          children: <Widget>[
//            Container(
//              height: 20,
//              margin: EdgeInsets.only(left: 10, top: 10),
//              child: Text(
//                "Facebook",
//                textAlign: TextAlign.left,
//                style: TextStyle(
//                  color: Color.fromARGB(255, 0, 0, 0),
//                  fontWeight: FontWeight.w400,
//                  fontSize: 14,
//                ),
//              ),
//            ),
//            Spacer(),
//            Container(
//              height: 20,
//              margin: EdgeInsets.only(left: 10, top: 10, right: 10),
//              child: Text(
//                getDateString(_date),
//                textAlign: TextAlign.left,
//                style: TextStyle(
//                  color: Color.fromARGB(255, 0, 0, 0),
//                  fontWeight: FontWeight.w400,
//                  fontSize: 14,
//                ),
//              ),
//            )
//          ],
//        ),
//        postView(),
//        Container(
//            width: MediaQuery.of(context).size.width,
//            child: Text(
//              "$_caption",
//              textAlign: TextAlign.start,
//            ),
//        )
//      ],
//      ),
//    );
//  }
}
