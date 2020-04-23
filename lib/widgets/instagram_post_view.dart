import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kronogram/UI_pages/values/colors.dart';
import 'package:kronogram/models/insta_post_data.dart';
import 'package:kronogram/models/media.dart';
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
    controller.setLooping(true);
    return controller;
  }

  Widget singleImage(InstaMedia media) {
    return CachedNetworkImage(
      imageUrl: media.url,
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }

  Widget postView() {
    return _isAlbum
        ? albumCarousel()
        : _media.length == 0 ? Container() : singleImage(_media[0]);
  }

  Widget albumCarousel() {
    return CarouselSlider(
      height: 280.0,
      items: _media.map((med) {
        if (med.type == "IMAGE") {
          return singleImage(med);
        }
        VideoPlayerController controller = getVideoPlayerController(med);
        Future<void> initFuture = controller.initialize();
        return Stack(
            children: <Widget>[FutureBuilder(
              future: initFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                // If the VideoPlayerController has finished initialization, use
                // the data it provides to limit the aspect ratio of the video.
                return AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                // Use the VideoPlayer widget to display the video.
                child: VideoPlayer(controller),
                );
               } else {
              // If the VideoPlayerController is still initializing, show a
              // loading spinner.
              return Center(child: CircularProgressIndicator());
            }
          }),
          FloatingActionButton(
            onPressed: () {
              // Wrap the play or pause in a call to `setState`. This ensures the
              // correct icon is shown.

                // If the video is playing, pause it.
                if (controller.value.isPlaying) {
                  controller.pause();
                } else {
                  // If the video is paused, play it.
                  controller.play();
                }

            },
            child: Icon(Icons.play_arrow)
            // Display the correct icon depending on the state of the player.
          )
        ]);
      }).toList(),
      enableInfiniteScroll: false,
    );
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
      ),
    );
  }

//  @override
//  Widget build(BuildContext context) {
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
//                "Instagram",
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
//          postView(),
//          Container(
//            width: MediaQuery.of(context).size.width,
//            child: Text(
//              "$_caption",
//              textAlign: TextAlign.start,
//            ),
//          )
//        ],
//      ),
//    );
//  }
}
