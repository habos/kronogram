
import 'package:flutter/material.dart';
import 'package:kronogram/UI_pages/osearch_bar_widget/osearch_bar_widget.dart';
import 'package:kronogram/UI_pages/settings_add_accounts_widget/settings_add_accounts_widget.dart';
import 'package:kronogram/UI_pages/values/values.dart';
import 'package:kronogram/UI_pages/user_timeline_widget/user_timeline_widget.dart';
import 'package:kronogram/UI_pages/user_map_widget/user_map_widget.dart';


class UserCurrentDateWidget extends StatelessWidget {

  void onButtonValueChanged(BuildContext context) {

  }

  void onnavigationBarItemPressed(BuildContext context) {

  }

  void onUsernamePressed(BuildContext context) {

  }

  void onSETTINGSPressed(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsAddAccountsWidget()));

  void onSEARCHPressed(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (context) => OSearchBarWidget()));
  void onMAPSPressed(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (context) => UserMapWidget()));
  void onTIMELINEPressed(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (context) => UserTimelineWidget()));
  void onDATEPressed(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (context) => UserCurrentDateWidget()));

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Column(

        children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FlatButton(
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

        ),
              Row(
    //mainAxisAlignment: MainAxisAlignment.end,
    //crossAxisAlignment: CrossAxisAlignment.center,
          height: 30,
          children: <Widget>[
          FlatButton(
          onPressed: () => this.onDATEPressed(context),
          textColor: Color.fromARGB(255, 112, 112, 112),
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
          textColor: Color.fromARGB(255, 112, 112, 112),
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
          textColor: Color.fromARGB(255, 112, 112, 112),
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
                    onChanged: (value) {

                    },
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



        backgroundColor: Color.fromARGB(255, 240, 247, 250),
        elevation: 0,
        automaticallyImplyLeading: false,
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
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              left: 10,
              top: 38,
              right: 11,
              child: Container(
                height: 594,
                decoration: BoxDecoration(
                  color: AppColors.ternaryBackground,
                  borderRadius: Radii.k10pxRadius,
                ),
                child: Container(),
              ),
            ),
            Positioned(
              left: 10,
              top: 42,
              right: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 35,
                    margin: EdgeInsets.only(left: 11),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.only(top: 18),
                            child: Text(
                              "TODAY…",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
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
                      ],
                    ),
                  ),
                  Container(
                    height: 628,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          right: 1,
                          child: Container(
                            height: 556,
                            decoration: BoxDecoration(
                              color: AppColors.secondaryBackground,
                              borderRadius: Radii.k10pxRadius,
                            ),
                            child: Container(),
                          ),
                        ),
                        Positioned(
                          left: 6,
                          top: 21,
                          right: 0,
                          bottom: 0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                height: 12,
                                margin: EdgeInsets.only(left: 3),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "1 year ago",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: AppColors.primaryText,
                                          fontFamily: "Helvetica Neue",
                                          fontWeight: FontWeight.w400,
                                          fontSize: 9,
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        width: 282,
                                        height: 1,
                                        margin: EdgeInsets.only(top: 5),
                                        decoration: BoxDecoration(
                                          color: AppColors.secondaryElement,
                                        ),
                                        child: Container(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 136,
                                margin: EdgeInsets.only(top: 4, right: 6),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryBackground,
                                  border: Border.fromBorderSide(Borders.primaryBorder),
                                ),
                                child: Container(),
                              ),
                              Container(
                                height: 12,
                                margin: EdgeInsets.only(left: 3, top: 23),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "3 years ago",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: AppColors.primaryText,
                                          fontFamily: "Helvetica Neue",
                                          fontWeight: FontWeight.w400,
                                          fontSize: 9,
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        width: 282,
                                        height: 1,
                                        margin: EdgeInsets.only(top: 8),
                                        decoration: BoxDecoration(
                                          color: AppColors.secondaryElement,
                                        ),
                                        child: Container(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 136,
                                margin: EdgeInsets.only(top: 2, right: 6),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryBackground,
                                  border: Border.fromBorderSide(Borders.primaryBorder),
                                ),
                                child: Container(),
                              ),
                              Container(
                                height: 136,
                                margin: EdgeInsets.only(top: 6, right: 6),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryBackground,
                                  border: Border.fromBorderSide(Borders.primaryBorder),
                                ),
                                child: Container(),
                              ),
                              Spacer(),
                              Container(
                                height: 136,
                                margin: EdgeInsets.only(right: 6),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryBackground,
                                  border: Border.fromBorderSide(Borders.primaryBorder),
                                ),
                                child: Container(),
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
          ],
        ),
      ),
    );
  }
}