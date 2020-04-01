import 'package:flutter/material.dart';
import 'package:kronogram/UI_pages/osearch_bar_widget/osearch_bar_widget.dart';
import 'package:kronogram/services/globals.dart' as globals;
import 'package:kronogram/UI_pages/values/values.dart';
import 'package:kronogram/UI_pages/user_timeline_widget/user_timeline_widget.dart';
import 'package:kronogram/UI_pages/user_map_widget/user_map_widget.dart';
import 'package:kronogram/UI_pages/user_current_date_widget/user_current_date_widget.dart';
import 'package:kronogram/pages/settings.dart';
import 'package:kronogram/services/authentication.dart';
import 'package:kronogram/services/database.dart';
import 'package:kronogram/services/stateful_wrapper.dart';

class myAppBar extends StatefulWidget {
//final double height;

  myAppBar({Key key, this.userId, this.logoutCallback})
      : super(key: key);

  final Database db = globals.db;
  final Auth auth = globals.auth;
  final String userId;
  final VoidCallback logoutCallback;
  String username;

  @override
  State<StatefulWidget> createState(){
    return _myAppBarState();
  }
}
  class _myAppBarState extends State<myAppBar>{

  void onnavigationBarItemPressed(BuildContext context) {}

  void onUsernamePressed(BuildContext context) {}

  void onSETTINGSPressed(BuildContext context) => Navigator.push(context,
      MaterialPageRoute(builder: (context) => SettingsPage(userId: widget.userId, logoutCallback: widget.logoutCallback)));
  void onSEARCHPressed(BuildContext context) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => OSearchBarWidget()));
  void onMAPSPressed(BuildContext context) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => UserMapWidget()));
  void onTIMELINEPressed(BuildContext context) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => UserTimelineWidget()));
  void onDATEPressed(BuildContext context) => Navigator.push(context,
      MaterialPageRoute(builder: (context) => UserCurrentDateWidget()));

  void setUsername(String userId) async{
    String user = await widget.db.getUsername(userId);
    setState(() {
      widget.username = user;
    });
  }
  @override
  void initState(){
    super.initState();
    setUsername(widget.userId);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: EdgeInsets.only(),
      decoration: BoxDecoration(
        color: AppColors.appBarBackground,
      ),

      child: Container(
        margin: EdgeInsets.only(top: 25, bottom: 5, left: 15,right:15),
        //child: userAppBar(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              flex: 15,
              child:Row(
                  children: <Widget>[
                    Expanded(
                      flex:1,
                    child: InkWell(
                      onTap: () => this.onnavigationBarItemPressed(context),
                      child: Text(
                        "@",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: AppColors.appBarText1,
                          fontWeight: FontWeight.w400,
                          fontSize: 22,
                        ),
                      ),

                    ),
                    ),
                    Expanded(
                      flex:12,
                    child:InkWell(
                      onTap: () => this.onUsernamePressed(context),

                      child: Text(
                        widget.username,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: AppColors.appBarText1,
                          fontWeight: FontWeight.w400,
                          fontSize: 25,
                        ),
                      ),
                    ),
                      ),
                  ]),
            ),
            Spacer(),

            Row(
                children: <Widget>[

                  InkWell(
                    onTap: () => this.onSETTINGSPressed(context),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        Icon(
                            Icons.settings_applications,
                            color: AppColors.appBarIcon,
                            size: 35
                        ),
                        //Transform.rotate(angle: 0.80, child:
                      ],
                    ),
                  ),

                  InkWell(
                    onTap: () => this.onSEARCHPressed(context),
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: <Widget>[
                        Icon(
                            Icons.search,
                            color: AppColors.appBarIcon,
                            size: 33
                        ),

                        //Transform.rotate(angle: 0.0, origin: Offset(60, 20), alignment:Alignment.topLeft, child:
                      ],
                    ),
                  ),
                ]

              //   ),
            ),

          ],
        ),
      )




      /*
            Column(
              children: <Widget>[

                Container (
                  height: 20,
                  child: FlatButton(
                    onPressed: () => this.onSEARCHPressed(context),

                    child: Text(
                      "SEARCH",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w400,
                        fontSize:20,
                      ),
                    ),
                  ),
                ),
                Container (
                  height: 12,

                  child: FlatButton(
                    //onPressed: () => this.onSETTINGSPressed(context),
                    color: Color.fromARGB(255, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    textColor: Color.fromARGB(255, 112, 112, 112),
                    padding: EdgeInsets.all(0),
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
                ),


              ],
            ),


          ],
        ),

      )


    child: Row (
      children: <Widget>[
        Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
    children: <Widget>[

      Align(
      alignment: Alignment.topLeft,

            //child: Container(
            //alignment: Alignment.centerLeft,
            //width: 300,
            child:Row(
              //crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FlatButton(
                    onPressed: () => this.onnavigationBarItemPressed(context),
                    textColor: Color.fromARGB(255, 112, 112, 112),
                    child: Text(
                      "@",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: AppColors.appBarButton,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    //),
                  ),
               FlatButton(
                    onPressed: () => this.onUsernamePressed(context),
                    /*
                color: Color.fromARGB(255, 255, 255, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                textColor: AppColors.appBarButton,
                */
                    padding: EdgeInsets.all(0),
                    child: Text(
                      "username",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: AppColors.appBarText1,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                  ),

              ],
            //),
                ),
      ),
            ],
            ),
          ],
        )
      ],
    ),
      */
    );
  }
  //@override
  //Size get preferredSize => Size.fromHeight(height);
}
/*
Widget userAppBar(){
  return new Container(
    child: Row(
      children: <Widget>[
        Row(
          children: <Widget>[
            FlatButton(
              // onPressed: () => this.onnavigationBarItemPressed(context),
              textColor: Color.fromARGB(255, 112, 112, 112),
              child: Text(
                "@",
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: AppColors.appBarButton,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              //),
            ),
            FlatButton(
              //onPressed: () => this.onUsernamePressed(context),
              /*
                color: Color.fromARGB(255, 255, 255, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                textColor: AppColors.appBarButton,
                */
              padding: EdgeInsets.all(0),
              child: Text(
                "username",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: AppColors.appBarText1,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
            ),
  ]),
            Spacer(),
            Column(
              children: <Widget>[

                Container (
                  height: 20,
                  child: FlatButton(
                    //onPressed: () => this.onSEARCHPressed(context),
                    color: Color.fromARGB(255, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    textColor: Color.fromARGB(255, 112, 112, 112),
                    //padding: EdgeInsets.all(0),
                    child: Text(
                      "SEARCH",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w400,
                        fontSize:20,
                      ),
                    ),
                  ),
                ),
                Container (
                  height: 12,

                  child: FlatButton(
                    //onPressed: () => this.onSETTINGSPressed(context),
                    color: Color.fromARGB(255, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    textColor: Color.fromARGB(255, 112, 112, 112),
                    padding: EdgeInsets.all(0),
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
                ),


              ],
            ),


          ],
        )

  );



}




@override
Widget build(BuildContext context) {
  return Container(
    height: 120,
    margin: EdgeInsets.only(top: 25),

    decoration: BoxDecoration(
      color: AppColors.blackBackground,
    ),

    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          //mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //Container(
            //height: 15,
            FlatButton(
              onPressed: () => this.onnavigationBarItemPressed(context),
              //color: AppColors.appBarButton,
              textColor: Color.fromARGB(255, 112, 112, 112),
              child: Text(
                "@",
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: AppColors.appBarButton,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              //),
            ),
            /*            Container(
                height: 15,
                width: 3,
                //color: Colors.black,
                margin: const EdgeInsets.only(),
              ),*/
            FlatButton(
              onPressed: () => this.onUsernamePressed(context),
              /*
                color: Color.fromARGB(255, 255, 255, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                textColor: AppColors.appBarButton,
                */
              padding: EdgeInsets.all(0),
              child: Text(
                "username",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: AppColors.appBarText1,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
            ),
            Spacer(),

            Column(
              children: <Widget>[

                Container (
                  height: 20,
                  child: FlatButton(
                    onPressed: () => this.onSEARCHPressed(context),
                    color: Color.fromARGB(255, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    textColor: Color.fromARGB(255, 112, 112, 112),
                    //padding: EdgeInsets.all(0),
                    child: Text(
                      "SEARCH",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w400,
                        fontSize:20,
                      ),
                    ),
                  ),
                ),
                Container (
                  height: 12,

                  child: FlatButton(
                    onPressed: () => this.onSETTINGSPressed(context),
                    color: Color.fromARGB(255, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    textColor: Color.fromARGB(255, 112, 112, 112),
                    padding: EdgeInsets.all(0),
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
                ),

              ],
            ),

          ],
        ),
        Row(
          //mainAxisAlignment: MainAxisAlignment.end,
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,

          children: <Widget>[
            FlatButton(
              onPressed: () => this.onDATEPressed(context),
              color: Color.fromARGB(255, 255, 255, 255),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              textColor: Color.fromARGB(255, 112, 112, 112),
              padding: EdgeInsets.all(0),
              child: Text(
                "TODAY",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
            ),
            FlatButton(
              onPressed: () => this.onTIMELINEPressed(context),
              color: Color.fromARGB(255, 255, 255, 255),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              textColor: Color.fromARGB(255, 112, 112, 112),
              padding: EdgeInsets.all(0),
              child: Text(
                "TIMELINE",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
            ),
            FlatButton(
              onPressed: () => this.onMAPSPressed(context),
              color: Color.fromARGB(255, 255, 255, 255),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              textColor: Color.fromARGB(255, 112, 112, 112),
              padding: EdgeInsets.all(0),
              child: Text(
                "MAPS",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
            ),
            Spacer(),
            Row(
              //mainAxisAlignment: MainAxisAlignment.end,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Switch.adaptive(
                    value: false,
                    inactiveTrackColor: Color.fromARGB(60, 0, 0, 0),
                    onChanged: (value) {},
                    activeColor: Color.fromARGB(255, 184, 184, 184),
                    activeTrackColor: AppColors.secondaryElement,
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "SHOW \nFREINDS",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    // maybe other AppBar properties
    //backgroundColor: Color.fromARGB(255, 240, 247, 250),
    //elevation: 0,
    //automaticallyImplyLeading: false,
    // ),
    //),
  );
}
//@override
//Size get preferredSize => Size.fromHeight(height);
}
*/
























/*
class myAppBar extends PreferredSizeWidget {
  //final String username;
  @override
  get preferredSize => Size.fromHeight(50);

  myAppBar({Key key, Widget title}) : super(
    key : key,
    title: title,
    // maybe other AppBar properties

    return new Container(
      padding: new EdgeInsets.only(top: statusbarHeight),
      height: statusbarHeight + barHeight,
      child: new Center(
        child: new Text(
          username,
          style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

*/
