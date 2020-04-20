import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kronogram/UI_pages/values/values.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

  GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
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
  }

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
                   )


                 ],

               )
             )

            ]
        ),




    );
  }
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
