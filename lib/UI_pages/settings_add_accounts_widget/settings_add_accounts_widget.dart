import 'package:flutter/material.dart';
import 'package:kronogram/UI_pages/login_page_widget/login_page_widget.dart';
import 'package:kronogram/UI_pages/values/values.dart';

class SettingsAddAccountsWidget extends StatelessWidget {
  void onConfirmPressed(BuildContext context) {}

  void onCancelPressed(BuildContext context) => Navigator.pop(context);

  void onLogoutPressed(BuildContext context) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => LoginPageWidget()));

  void onTwitterSignInPressed(BuildContext context) {}

  void onEditBirthDatePressed(BuildContext context) {}
  void onInstagramSignInPressed(BuildContext context) {}

  void onFacebookSignInPressed(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 226, 227, 231),
          border: Border.all(
            width: 1,
            color: Color.fromARGB(255, 112, 112, 112),
          ),
        ),
        child: ListView(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                height: 40,
                margin: EdgeInsets.only(left: 15, top: 25),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      child: Text(
                        "\"USERNAME\"",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromARGB(255, 3, 3, 3),
                          fontFamily: "Helvetica Neue",
                          fontWeight: FontWeight.w400,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    Spacer(),
                    Align(
                      child: Container(
                        //height: 70,
                        //margin: EdgeInsets.only(),
                        //child: Row(
                        //margin: EdgeInsets.only(left:15, top: 10),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Row(
                                children: [
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Container(
                                      height: 20,
                                      margin: EdgeInsets.only(left: 60),
                                      child: Switch.adaptive(
                                        value: false,
                                        inactiveTrackColor:
                                            Color.fromARGB(60, 0, 0, 0),
                                        onChanged: (value) {},
                                        activeColor:
                                            Color.fromARGB(255, 184, 184, 184),
                                        activeTrackColor:
                                            AppColors.secondaryElement,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      "PRIVATE",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Row(children: [
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    "Birthday:",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 3, 3, 3),
                                      fontFamily: "Helvetica Neue",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      "01/01/2001",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 112, 112, 112),
                                        fontFamily: "Helvetica Neue",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                    width: 40,
                                    height: 15,
                                    margin: EdgeInsets.only(left: 10),
                                    child: FlatButton(
                                      onPressed: () =>
                                          this.onEditBirthDatePressed(context),
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      textColor:
                                          Color.fromARGB(255, 112, 112, 112),
                                      padding: EdgeInsets.all(0),
                                      child: Text(
                                        "EDIT",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 112, 112, 112),
                                          fontFamily: "Helvetica Neue",
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            /*
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            //width: 300,
            height: 20,
            margin: EdgeInsets.only(left:135, top: 10),
            child: ListView(
              children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                      children: [
              Align(
              alignment: Alignment.bottomRight,
              child: Text(
                "Birthday:",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 3, 3, 3),
                  fontFamily: "Helvetica Neue",
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                ),
              ),
            ),

                  Align(
                alignment: Alignment.bottomLeft,
                    child: Container(
                    margin: EdgeInsets.only(left:20),
                child: Text(
                    "01/01/2001",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 112, 112, 112),
                      fontFamily: "Helvetica Neue",
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                  ),
                  ),
                  ),

              Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                width: 70,
                height: 15,
                margin: EdgeInsets.only(left: 20),
                child:FlatButton(
                  onPressed: () => this.onCancelPressed(context),
                  color: Color.fromARGB(255, 255, 255, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  textColor: Color.fromARGB(255, 112, 112, 112),
                  padding: EdgeInsets.all(0),
                      child: Text(
                        "EDIT",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromARGB(255, 112, 112, 112),
                          fontFamily: "Helvetica Neue",
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                        ),
                      ),
              ),
                  ),
              ),
                ]
              ),

            ),

*/

            /*Container(
              height: 20,
              margin: EdgeInsets.only(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: EdgeInsets.only(),
                      child: Text(
                        "MONTH",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromARGB(255, 3, 3, 3),
                          fontFamily: "Helvetica Neue",
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 20,
                      height: 20,
                      margin: EdgeInsets.only(),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "01",
                          contentPadding: EdgeInsets.all(0),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: Color.fromARGB(255, 112, 112, 112),
                          fontFamily: "Helvetica Neue",
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                        ),
                        maxLines: 1,
                        autocorrect: false,
                      ),
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      height: 20,
                      margin: EdgeInsets.only(left: 5),
                      child: Text(
                        "DAY",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromARGB(255, 3, 3, 3),
                          fontFamily: "Helvetica Neue",
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 20,
                      height: 20,
                      margin: EdgeInsets.only(),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "01",
                          contentPadding: EdgeInsets.all(0),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: Color.fromARGB(255, 112, 112, 112),
                          fontFamily: "Helvetica Neue",
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                        ),
                        maxLines: 1,
                        autocorrect: false,
                      ),
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Text(
                        "YEAR",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromARGB(255, 3, 3, 3),
                          fontFamily: "Helvetica Neue",
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: 40,
                      height: 20,
                      margin: EdgeInsets.only(right: 10),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "1999",
                          contentPadding: EdgeInsets.all(0),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: Color.fromARGB(255, 112, 112, 112),
                          fontFamily: "Helvetica Neue",
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                        ),
                        maxLines: 1,
                        autocorrect: false,
                      ),
                    ),
                  ),
                ],
              ),


            ),
            ],
          ),
        ),

      ),*/
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 300,
                height: 165,
                margin: EdgeInsets.only(left: 15, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add Accounts:",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 3, 3, 3),
                        fontFamily: "Helvetica Neue",
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 30,
                      margin: EdgeInsets.only(left: 60, top: 15),
                      child: FlatButton(
                        onPressed: () => this.onFacebookSignInPressed(context),
                        color: Color.fromARGB(0, 0, 0, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                        ),
                        textColor: Color.fromARGB(255, 112, 112, 112),
                        padding: EdgeInsets.all(0),
                        child: Text(
                          "Facebook",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color.fromARGB(255, 112, 112, 112),
                            fontFamily: "Helvetica Neue",
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 30,
                      margin: EdgeInsets.only(left: 60, top: 15),
                      child: FlatButton(
                        onPressed: () => this.onInstagramSignInPressed(context),
                        color: Color.fromARGB(0, 0, 0, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                        ),
                        textColor: Color.fromARGB(255, 112, 112, 112),
                        padding: EdgeInsets.all(0),
                        child: Text(
                          "Instagram",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color.fromARGB(255, 112, 112, 112),
                            fontFamily: "Helvetica Neue",
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 30,
                      margin: EdgeInsets.only(left: 60, top: 15),
                      child: FlatButton(
                        onPressed: () => this.onTwitterSignInPressed(context),
                        color: Color.fromARGB(0, 0, 0, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                        ),
                        textColor: Color.fromARGB(255, 112, 112, 112),
                        padding: EdgeInsets.all(0),
                        child: Text(
                          "Twitter",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color.fromARGB(255, 112, 112, 112),
                            fontFamily: "Helvetica Neue",
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 300,
                height: 185,
                margin: EdgeInsets.only(left: 15, top: 32),
                child: ListView(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Change Password:",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromARGB(255, 3, 3, 3),
                          fontFamily: "Helvetica Neue",
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      width: 270,
                      height: 25,
                      margin: EdgeInsets.only(top: 5, left: 15),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "current password",
                          contentPadding: EdgeInsets.all(0),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: Color.fromARGB(255, 112, 112, 112),
                          fontFamily: "Helvetica Neue",
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                        obscureText: true,
                        maxLines: 1,
                        autocorrect: false,
                      ),
                    ),
                    Container(
                      width: 270,
                      height: 25,
                      margin: EdgeInsets.only(top: 15, left: 60),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "new password",
                          contentPadding: EdgeInsets.all(0),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: Color.fromARGB(255, 112, 112, 112),
                          fontFamily: "Helvetica Neue",
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                        obscureText: true,
                        maxLines: 1,
                        autocorrect: false,
                      ),
                    ),
                    Container(
                      width: 270,
                      height: 40,
                      margin: EdgeInsets.only(top: 15, left: 60),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "confirm password",
                          contentPadding: EdgeInsets.all(0),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: Color.fromARGB(255, 112, 112, 112),
                          fontFamily: "Helvetica Neue",
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                        obscureText: true,
                        maxLines: 1,
                        autocorrect: false,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 29,
              margin: EdgeInsets.only(left: 50, right: 50, bottom: 21),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: 100,
                      height: 29,
                      child: FlatButton(
                        onPressed: () => this.onConfirmPressed(context),
                        color: Color.fromARGB(255, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        textColor: Color.fromARGB(255, 112, 112, 112),
                        padding: EdgeInsets.all(0),
                        child: Text(
                          "CONFIRM",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color.fromARGB(255, 112, 112, 112),
                            fontFamily: "Helvetica Neue",
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: 100,
                      height: 29,
                      child: FlatButton(
                        onPressed: () => this.onCancelPressed(context),
                        color: Color.fromARGB(255, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        textColor: Color.fromARGB(255, 112, 112, 112),
                        padding: EdgeInsets.all(0),
                        child: Text(
                          "CANCEL",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color.fromARGB(255, 112, 112, 112),
                            fontFamily: "Helvetica Neue",
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 270,
                height: 29,
                margin: EdgeInsets.only(bottom: 36),
                child: FlatButton(
                  onPressed: () => this.onLogoutPressed(context),
                  color: Color.fromARGB(255, 255, 255, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  textColor: Color.fromARGB(255, 112, 112, 112),
                  padding: EdgeInsets.all(0),
                  child: Text(
                    "LOG OUT",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 112, 112, 112),
                      fontFamily: "Helvetica Neue",
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
