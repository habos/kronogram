
import 'package:flutter/material.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kronogram/UI_pages/osearch_bar_widget/osearch_bar_widget.dart';
import 'package:kronogram/UI_pages/settings_add_accounts_widget/settings_add_accounts_widget.dart';
import 'package:kronogram/UI_pages/values/values.dart';

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: FlatButton(
          onPressed: () => this.onnavigationBarItemPressed(context),
          textColor: Color.fromARGB(255, 112, 112, 112),
          child: Text(
            "@",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ),
        actions: [
          FlatButton(
            onPressed: () => this.onUsernamePressed(context),
            textColor: Color.fromARGB(255, 112, 112, 112),
            child: Text(
              "username",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ),
          FlatButton(
            onPressed: () => this.onSETTINGSPressed(context),
            textColor: Color.fromARGB(255, 112, 112, 112),
            child: Text(
              "SETTINGS",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ),
          FlatButton(
            onPressed: () => this.onSEARCHPressed(context),
            textColor: Color.fromARGB(255, 112, 112, 112),
            child: Text(
              "SEARCH",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    Container(
                      width: 52,
                      height: 32,
                      margin: EdgeInsets.only(top: 18, right: 2),
                      child: Switch.adaptive(
                        value: false,
                        inactiveTrackColor: Color.fromARGB(60, 0, 0, 0),
                        onChanged: (value) {

                        },
                        activeColor: Color.fromARGB(255, 184, 184, 184),
                        activeTrackColor: AppColors.secondaryElement,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 18, left:5, right: 4),
                      child: Text(
                        "SHOW FREINDS",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ),
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