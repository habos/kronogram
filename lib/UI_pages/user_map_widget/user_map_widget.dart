
import 'package:flutter/material.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kronogram/UI_pages/osearch_bar_widget/osearch_bar_widget.dart';
import 'package:kronogram/UI_pages/settings_add_accounts_widget/settings_add_accounts_widget.dart';
import 'package:kronogram/UI_pages/values/values.dart';
import 'package:kronogram/UI_pages/my_app_bar/my_app_bar.dart';

// to use google maps plug in : https://pub.dev/packages/google_maps_flutter
class UserMapWidget extends StatelessWidget {
  
  void onFriendsValueChanged(BuildContext context) {
  
  }
  
  void onnavigationBarItemPressed(BuildContext context) {
  
  }
  
  void onUsernamePressed(BuildContext context) {
  
  }
  
  void onSETTINGSPressed(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsAddAccountsWidget()));
  
  void onSEARCHPressed(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (context) => OSearchBarWidget()));
  
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(110.0),
        child: myAppBar(
          //height: 100,
        ),

      ),

      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 225, 226, 230),
          border: Border.all(
            width: 1,
            color: Color.fromARGB(255, 112, 112, 112),
          ),
        ),
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width:235,
                height: 35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                  ],
                ),
              ),
            ),

            Container(
              height: 555,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      "asset/images/map-image.png"
                    ),
                  ),
                    /*child: GoogleMap(
                      onMapCreated: (controller) {
                      
                      },
                    ),
                  ),*/
                  Positioned(
                    left: 164,
                    top: 53,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 16,
                          height: 17,
                          margin: EdgeInsets.only(left: 42),
                          child: Image.asset(
                            "assets/images/map-pin.png",
                            fit: BoxFit.none,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width: 16,
                            height: 17,
                            margin: EdgeInsets.only(top: 121),
                            child: Image.asset(
                              "assets/images/map-pin.png",
                              fit: BoxFit.none,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width: 27,
                            height: 28,
                            margin: EdgeInsets.only(top: 69, right: 92),
                            child: Image.asset(
                              "assets/images/map-pin-4.png",
                              fit: BoxFit.none,
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: 16,
                          height: 17,
                          child: Image.asset(
                            "assets/images/map-pin.png",
                            fit: BoxFit.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}