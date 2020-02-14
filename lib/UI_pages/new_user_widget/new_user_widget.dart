
import 'package:flutter/material.dart';
import 'package:kronogram/UI_pages/login_page_widget/login_page_widget.dart';
import 'package:kronogram/UI_pages/values/values.dart';


class NewUserWidget extends StatelessWidget {
  
  void onLoginPressed(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPageWidget()));
  
  void onCancelPressed(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPageWidget()));
  
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: 15, top: 60),
                child: Text(
                  "Add Accounts:",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 3, 3, 3),
                    fontFamily: "Helvetica Neue",
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 270,
                height: 40,
                margin: EdgeInsets.only(top: 11),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Facebook username",
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
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 270,
                height: 40,
                margin: EdgeInsets.only(top: 15),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Instagram username",
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
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 270,
                height: 40,
                margin: EdgeInsets.only(top: 15),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Twitter username",
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
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 270,
                height: 40,
                margin: EdgeInsets.only(top: 15),
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
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: 15, top: 49),
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
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 270,
                height: 40,
                margin: EdgeInsets.only(top: 11),
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
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 270,
                height: 40,
                margin: EdgeInsets.only(top: 5),
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
            ),
            Spacer(),
            Container(
              height: 29,
              margin: EdgeInsets.only(left: 73, right: 60, bottom: 113),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: 100,
                      height: 29,
                      child: FlatButton(
                        onPressed: () => this.onLoginPressed(context),
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