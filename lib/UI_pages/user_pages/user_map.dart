import 'package:flutter/material.dart';
import 'package:kronogram/UI_pages/values/values.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';


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

            child: FlutterMap(
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
            ),
            constraints: BoxConstraints.expand(
                height: 400.0
            ),
          ),

             Text( "Locations: ",
                textAlign: TextAlign.left,
                style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.w600,
                fontSize: 20
                ),
              ),
            ]
        ),




    );
  }
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
