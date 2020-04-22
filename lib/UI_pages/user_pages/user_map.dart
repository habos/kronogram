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
  bool _loadingP = true;
  bool _loadingM = true;
  var locCount =0;
  String curLocDate ="NA";
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{}; // CLASS MEMBER, MAP OF MARKS

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
        //initMarker(tweet, tweet.getCreationTime());

      }

    }

    Map facebookUser = await db.getFacebookInfo(widget.userId);
    List<KronoFacebookPost> posts = await APIcaller.requestFbPosts(facebookUser);
    for (KronoFacebookPost post in posts) {
      if(post.getLocation()!=null){
        postLocations.add(post);
        //initMarker(post, post.getCreationTime());
      }
    }

    postLocations.sort((a, b) => a.getCreationTime().compareTo(b.getCreationTime()) * -1);

/*
      for (var i = 0; i < postLocations.length; i++) {
        initMarker(postLocations[i], postLocations[i].getCreationTime());

      _loadingM=false;
    }
*/
    _loadingP=false;
  //_loadingM=false;
    //createMarkers();
    setState(() {
      _loadingP=false;
      //_loadingM=false;
    });

  }

  void createMarkers() {


    if(postLocations.isNotEmpty) {
      print("locationsnotempty");
      for (var i = 0; i < postLocations.length; i++) {
        initMarker(postLocations[i], getDateString(postLocations[i].getCreationTime()));
      }
      _loadingM=false;
    }

    setState(() {
      // adding a new marker to map
      //_loadingM=false;
    });
  }

  void initMarker(post, postId) {
    var markerIdVal = postId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng((post.getLocation()).latitude, (post.getLocation()).longitude ),
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(title: (getDateString(post.getCreationTime()))),
    );
    //markers.add(marker1);

    setState(() {
      markers[markerId] = marker;
      print(markerId);
    });

  }


  Widget progress() {
    return new Container(
      child: new Stack(
        children: <Widget>[
          new Container(
            alignment: AlignmentDirectional.center,
            decoration: new BoxDecoration(
              color: Colors.white70,
            ),
            child: new Container(
              decoration: new BoxDecoration(
                  color: AppColors.voidBackground10,
                  borderRadius: new BorderRadius.circular(10.0)
              ),
              width: 300.0,
              height: 200.0,
              alignment: AlignmentDirectional.center,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Center(
                    child: new SizedBox(
                      height: 50.0,
                      width: 50.0,
                      child: new CircularProgressIndicator(
                        value: null,
                        strokeWidth: 7.0,
                        valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  ),
                  new Container(
                    margin: const EdgeInsets.only(top: 25.0),
                    child: new Center(
                      child: new Text(
                        "loading...",
                        style: new TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
    createMarkers();
  }

  @override
  Widget build(BuildContext context) {
    if (_loadingP) {
      return progress();
    }
    else {
      if (_loadingM) {
        createMarkers();
        return progress();
      }
      else {
        if (postLocations.length == 0) {
          return Container(
            color: AppColors.primaryBackground,
            child: Text(
              "There are no locations available",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w600,
                  fontSize: 20
              ),
            ),
          );
        }
        else {
          return Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: GoogleMap(
                    markers: Set<Marker>.of(markers.values),
                    initialCameraPosition: CameraPosition(
                      target: LatLng(33.209900, -87.548200),
                      //markers[1].position,
                      zoom: 11.0,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      mapController = controller;
                    },
                    //markers: _markers.values.toSet(),
                  ),

                  constraints: BoxConstraints.expand(
                      height: 500.0
                  ),
                ),

                Container(
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FloatingActionButton.extended(
                            onPressed: _viewlast,
                            label: Text('LAST'),
                            icon: Icon(Icons.pin_drop),
                            backgroundColor: AppColors.voidBackground6,
                          ),
                          FloatingActionButton.extended(
                            onPressed: _viewALL,
                            label: Text('VIEW ALL'),
                            //icon: Icon(Icons.public),
                            backgroundColor: AppColors.voidBackground6,
                          ),
                          FloatingActionButton.extended(
                            onPressed: _viewnext,
                            label: Text('NEXT'),
                            icon: Icon(Icons.pin_drop),
                            backgroundColor: AppColors.voidBackground6,
                          ),
                        ],
                      ),



                    ],
                  ),


                ),
              ],),);
        }
      }
    }

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
  Future<void> _viewALL() async {
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        (CameraPosition(
          target: LatLng((postLocations[locCount].getLocation()).latitude, (postLocations[locCount].getLocation()).longitude),
          zoom: 3,))));
  }
  Future<void> _viewnext() async {
    locCount++;
    if (locCount > postLocations.length){
      locCount=0;
    }
    curLocDate = getDateString(postLocations[locCount].getCreationTime());

    mapController.animateCamera(CameraUpdate.newCameraPosition(
        (CameraPosition(
        target: LatLng((postLocations[locCount].getLocation()).latitude, (postLocations[locCount].getLocation()).longitude),
        zoom: 13.5,))));
    mapController.showMarkerInfoWindow(MarkerId(getDateString(postLocations[locCount].getCreationTime())));
  }
  Future<void> _viewlast() async {
    locCount--;
    if (locCount <0 ){
      locCount=postLocations.length;
    }
    curLocDate = getDateString(postLocations[locCount].getCreationTime());

    mapController.animateCamera(CameraUpdate.newCameraPosition(
        (CameraPosition(
          target: LatLng((postLocations[locCount].getLocation()).latitude, (postLocations[locCount].getLocation()).longitude),
          zoom: 13.5,))));
    mapController.showMarkerInfoWindow(MarkerId(getDateString(postLocations[locCount].getCreationTime())));
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
