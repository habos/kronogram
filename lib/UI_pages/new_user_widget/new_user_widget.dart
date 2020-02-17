
import 'package:flutter/material.dart';
import 'package:kronogram/UI_pages/login_page_widget/login_page_widget.dart';
import 'package:kronogram/UI_pages/values/values.dart';



class NewUserWidget extends StatelessWidget {

  void onCreatePressed(BuildContext context) {

  }

  void onCancelPressed(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPageWidget()));

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //resizeToAvoidBottomPadding: false,
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
                width: 300,
                height: 136,
                margin: EdgeInsets.only(left: 14, top: 29),
                child: ListView(
                  children: [
                    Text(
                      "Enter Email",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromARGB(255, 3, 3, 3),
                        fontFamily: "Helvetica Neue",
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    Container(
                        width: 272,
                        height: 25,
                        margin: EdgeInsets.only(top: 17, left: 20),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  contentPadding: EdgeInsets.all(0),
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(
                                  color: Color.fromARGB(255, 112, 112, 112),
                                  fontFamily: "Helvetica Neue",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),
                                maxLines: 1,
                                autocorrect: false,
                              ),
                            ),
                    Container(
                      width: 272,
                      height: 25,
                      margin: EdgeInsets.only(top: 17, left: 20),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Confirm Email",
                                  contentPadding: EdgeInsets.all(0),
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(
                                  color: Color.fromARGB(255, 112, 112, 112),
                                  fontFamily: "Helvetica Neue",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),
                                maxLines: 1,
                                autocorrect: false,
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
                height: 136,
                margin: EdgeInsets.only(left: 14, top: 29),
                child: ListView(
                  children: [
                    Text(
                      "Create Username",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromARGB(255, 3, 3, 3),
                        fontFamily: "Helvetica Neue",
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      width: 272,
                      height: 25,
                      margin: EdgeInsets.only(top: 17, left: 20),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Username",
                          contentPadding: EdgeInsets.all(0),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: Color.fromARGB(255, 112, 112, 112),
                          fontFamily: "Helvetica Neue",
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                        maxLines: 1,
                        autocorrect: false,
                      ),
                    ),
                    Container(
                      width: 272,
                      height: 25,
                      margin: EdgeInsets.only(top: 17, left: 20),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Confirm Username",
                          contentPadding: EdgeInsets.all(0),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: Color.fromARGB(255, 112, 112, 112),
                          fontFamily: "Helvetica Neue",
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                        maxLines: 1,
                        autocorrect: false,
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
                height: 175,
                margin: EdgeInsets.only(left: 15, top: 29),
                child: ListView(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Create Password:",
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
                      margin: EdgeInsets.only(top: 15, left: 20),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "password",
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
                      height: 35,
                      margin: EdgeInsets.only(top: 15, left: 20),
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
              margin: EdgeInsets.only(left: 60, right: 60, bottom: 21),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: 100,
                      height: 29,
                      child: FlatButton(
                        onPressed: () => this.onCreatePressed(context),
                        color: Color.fromARGB(255, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        textColor: Color.fromARGB(255, 112, 112, 112),
                        padding: EdgeInsets.all(0),
                        child: Text(
                          "CREATE",
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
          ],
        ),
      ),
    );
  }
}