
import 'package:flutter/material.dart';
import 'package:kronogram/UI_pages/new_user_widget/new_user_widget.dart';
import 'package:kronogram/UI_pages/user_current_date_widget/user_current_date_widget.dart';
import 'package:kronogram/UI_pages/values/values.dart';


class LoginPageWidget extends StatelessWidget {
  
  void onLoginPressed(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (context) => UserCurrentDateWidget()));
  
  void onButtonPressed(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (context) => NewUserWidget()));
  
  void onCancelPressed(BuildContext context) {
  
  }
  
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
              alignment: Alignment.topCenter,
              child: Container(
                width: 201,
                height: 203,
                margin: EdgeInsets.only(top: 91),
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Positioned(
                      right: 67,
                      child: Text(
                        "LOGO",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromARGB(255, 112, 112, 112),
                          fontFamily: "Helvetica Neue",
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      child: Image.asset(
                        "assets/images/logo-background.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 270,
                height: 40,
                margin: EdgeInsets.only(top: 36),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "username",
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
                margin: EdgeInsets.only(top: 35),
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
              margin: EdgeInsets.only(left: 73, right: 60, bottom: 21),
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
                          "LOGIN",
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
              alignment: Alignment.topCenter,
              child: Container(
                width: 348,
                height: 44,
                child: FlatButton(
                  onPressed: () => this.onButtonPressed(context),
                  color: Color.fromARGB(0, 0, 0, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                  ),
                  textColor: Color.fromARGB(255, 0, 0, 0),
                  padding: EdgeInsets.all(0),
                  child: Text(
                    "New User? SIGN UP !!",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontFamily: "Ayuthaya",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
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