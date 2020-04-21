import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kronogram/UI_pages/values/values.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


import 'package:kronogram/models/krono_fb_post.dart';
import 'package:kronogram/models/krono_insta_post.dart';
import 'package:kronogram/models/krono_post.dart';
import 'package:kronogram/models/krono_tweet.dart';
import 'package:kronogram/models/sm_platform.dart';
import 'package:kronogram/services/globals.dart';
import 'package:kronogram/utils/date_utils.dart';
import 'package:kronogram/widgets/post_view.dart';


//import 'package:flutter_map/flutter_map.dart';
//import 'package:latlong/latlong.dart';


class UserMap extends StatefulWidget{
  UserMap({Key key, this.userId})
      :super(key:key);

  final String userId;

  @override
  State<StatefulWidget> createState(){
    return _UserMapState();
  }
}

class _UserMapState extends State<UserMap> {
  //Completer<GoogleMapController> _controller = Completer();
  //final LatLng _center = const LatLng(45.521563, -122.677433);
  List<KronoPost> postLocations = List();
  GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }




  void getPosts() async{

    Map twitterUser = await db.getTwitterInfo(widget.userId);
    List<KronoTweet> tweets = await APIcaller.requestTweets(twitterUser);
    for (KronoTweet tweet in tweets) {
      if(tweet.getLocation()!=null){
        postLocations.add(tweet);
      }

    }

    Map facebookUser = await db.getFacebookInfo(widget.userId);
    List<KronoFacebookPost> posts = await APIcaller.requestFbPosts(facebookUser);
    for (KronoFacebookPost post in posts) {
      if(post.getLocation()!=null){
        postLocations.add(post);
      }
    }

    postLocations.sort((a, b) => a.getCreationTime().compareTo(b.getCreationTime()) * -1);
    setState(() {

    });
  }

/*
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final userlocations = await locations.getuserlocations();
    setState(() {
      _markers.clear();
      for (final locat in userlocations.location) {
        final marker = Marker(
          markerId: MarkerId(location.date),
          position: LatLng(location.lat, location.lng),
          infoWindow: InfoWindow(
            title: location.date,
          ),
        );
        _markers[location.date] = marker;
      }
    });
  }
 */


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: postLocations.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Row(
                  children: <Widget>[
                    Text(
                        'DATE: ' + getDateString(postLocations[index].getCreationTime()) + ' : '
                    ),
                    if (postLocations[index].getLocation()!= null)
                      Text(
                        //timelinePosts[index].getLocation()).toString(),
                          ((postLocations[index].getLocation()).latitude)
                              .toString() + ' ' +
                              ((postLocations[index].getLocation()).longitude)
                                  .toString()

                      ),


                  ],
                ),


              );
            })
    );
  }


  /*

  @override
  Widget build(BuildContext context) {
    return Container(
      child:Column(

        children: <Widget> [
          Container(
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
              ),
            /*child: FlutterMap(
              options: new MapOptions(
                center: new LatLng(33.209900, -87.548200),
                zoom: 13.0,
              ),
              layers: [
                new TileLayerOptions(
                    urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c']
                ),
                new MarkerLayerOptions(
                  markers: [
                    new Marker(
                      width: 80.0,
                      height: 80.0,
                      point: new LatLng(33.209900, -87.548200),
                      builder: (ctx) =>
                      new Container(
                        child: Icon(Icons.account_balance ),
                      ),
                    ),
                  ],
                ),
              ],
            ),*/
            constraints: BoxConstraints.expand(
                height: 400.0
            ),
          ),

             Container(
               child: Column(
                 children: <Widget>[
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: <Widget>[
                       Text( "Locations: ",
                         textAlign: TextAlign.left,
                         style: TextStyle(
                             color: Color.fromARGB(255, 0, 0, 0),
                             fontWeight: FontWeight.w600,
                             fontSize: 20
                         ),
                       ),
                       FloatingActionButton.extended(
                         onPressed: _viewAll,
                         label: Text('VIEW ALL'),
                         icon: Icon(Icons.pin_drop),
                         backgroundColor: AppColors.voidBackground6,
                       ),
                     ],
                   ),
                    /*
                    Container(
                      child:ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: timelinePosts.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            child: Row(
                            children: <Widget>[
                              Text(
                                'LOCATION '+ index.toString() + ' : '
                              ),
                              Text(
                              (timelinePosts[index].getLocation()).toString(),
                              )
                              ],
                            ),


                          );
                        })
                    )
*/
                 ],

               )
             )

            ]
        ),



    );
  }

   */
  Future<void> _viewAll() async {
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        (CameraPosition(
        target: LatLng(33.209900, -87.548200),
        zoom: 13.5,))));
  }
}
class locationsTemp{
  locationsTemp({
    this.date, this.lat, this.lng,});
  final String date;
  final double lat;
  final double lng;
}


class PlaceholderWidget extends StatelessWidget {
  final Color color;

  PlaceholderWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}
