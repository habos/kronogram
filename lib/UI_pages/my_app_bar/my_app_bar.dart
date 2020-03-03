import 'package:flutter/material.dart';
import 'package:kronogram/UI_pages/osearch_bar_widget/osearch_bar_widget.dart';
import 'package:kronogram/UI_pages/settings_add_accounts_widget/settings_add_accounts_widget.dart';
import 'package:kronogram/UI_pages/values/values.dart';
import 'package:kronogram/UI_pages/user_timeline_widget/user_timeline_widget.dart';
import 'package:kronogram/UI_pages/user_map_widget/user_map_widget.dart';
import 'package:kronogram/UI_pages/user_current_date_widget/user_current_date_widget.dart';

class myAppBar extends StatelessWidget {
//final double height;

  void onnavigationBarItemPressed(BuildContext context) {}

  void onUsernamePressed(BuildContext context) {}

  void onSETTINGSPressed(BuildContext context) => Navigator.push(context,
      MaterialPageRoute(builder: (context) => SettingsAddAccountsWidget()));
  void onSEARCHPressed(BuildContext context) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => OSearchBarWidget()));
  void onMAPSPressed(BuildContext context) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => UserMapWidget()));
  void onTIMELINEPressed(BuildContext context) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => UserTimelineWidget()));
  void onDATEPressed(BuildContext context) => Navigator.push(context,
      MaterialPageRoute(builder: (context) => UserCurrentDateWidget()));

//class myAppBar extends PreferredSize {
  const myAppBar({
    Key key,
//@required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: EdgeInsets.only(top: 25),

      decoration: BoxDecoration(
        color: AppColors.blackBackground,
      ),

      child: Column(
        children: [
          Row(
            //mainAxisAlignment: MainAxisAlignment.end,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 15,
                child: FlatButton(
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
              ),
              Container(
                height: 15,
                width: 3,
                color: Colors.black,
                margin: const EdgeInsets.only(),
              ),
              FlatButton(
                onPressed: () => this.onUsernamePressed(context),
                color: Color.fromARGB(255, 255, 255, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                textColor: Color.fromARGB(255, 112, 112, 112),
                padding: EdgeInsets.all(0),
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
              FlatButton(
                onPressed: () => this.onSEARCHPressed(context),
                color: Color.fromARGB(255, 255, 255, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                textColor: Color.fromARGB(255, 112, 112, 112),
                padding: EdgeInsets.all(1),
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
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.end,
            //crossAxisAlignment: CrossAxisAlignment.center,

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
