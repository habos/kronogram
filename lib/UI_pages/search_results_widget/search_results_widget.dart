
import 'package:flutter/material.dart';
import 'package:kronogram/UI_pages/user_current_date_widget/user_current_date_widget.dart';
import 'package:kronogram/UI_pages/values/values.dart';


class SearchResultsWidget extends StatelessWidget {
  
  void onCancelButtonPressed(BuildContext context) => Navigator.pop(context);
  
  void onSearchButtonPressed(BuildContext context) {
  
  }
  
  void onSymbolPressed(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (context) => UserCurrentDateWidget()));
  
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 242, 243, 244),
          border: Border.all(
            width: 1,
            color: Color.fromARGB(255, 112, 112, 112),
          ),
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              left: 12,
              top: 38,
              right: 9,
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
              left: 12,
              top: 3,
              right: 9,
              child: Container(
                height: 629,
                decoration: BoxDecoration(
                  color: Color.fromARGB(242, 225, 226, 230),
                  border: Border.fromBorderSide(Borders.primaryBorder),
                  borderRadius: Radii.k10pxRadius,
                ),
                child: Container(),
              ),
            ),
            Positioned(
              left: 16,
              top: -2,
              right: 13,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 247,
                      height: 622,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              width: 247,
                              height: 45,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      margin: EdgeInsets.only(top: 8),
                                      child: FlatButton(
                                        onPressed: () => this.onSymbolPressed(context),
                                        color: AppColors.primaryElement,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(15)),
                                        ),
                                        textColor: Color.fromARGB(255, 112, 112, 112),
                                        padding: EdgeInsets.all(0),
                                        child: Text(
                                          "@",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: AppColors.primaryText,
                                            fontFamily: "Helvetica Neue",
                                            fontWeight: FontWeight.w400,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      width: 214,
                                      height: 45,
                                      margin: EdgeInsets.only(left: 3),
                                      decoration: BoxDecoration(
                                        borderRadius: Radii.k10pxRadius,
                                      ),
                                      child: Container(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              width: 145,
                              height: 574,
                              margin: EdgeInsets.only(left: 2, top: 3),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    "search results…",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: AppColors.primaryText,
                                      fontFamily: "Helvetica Neue",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 543,
                                    margin: EdgeInsets.only(top: 31),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Positioned(
                                          left: 13,
                                          top: 0,
                                          child: Image.asset(
                                            "assets/images/path-1.png",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                          left: 0,
                                          top: 79,
                                          right: 0,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              Container(
                                                height: 18,
                                                child: ListView.builder(
                                                  itemCount: 15,
                                                ),
                                              ),
                                              Container(
                                                height: 18,
                                                margin: EdgeInsets.only(top: 32),
                                                child: ListView.builder(
                                                  itemCount: 15,
                                                ),
                                              ),
                                              Container(
                                                height: 18,
                                                margin: EdgeInsets.only(top: 32),
                                                child: ListView.builder(
                                                  itemCount: 15,
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
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 40,
                      height: 29,
                      margin: EdgeInsets.only(top: 8, right: 2),
                      child: FlatButton(
                        onPressed: () => this.onSearchButtonPressed(context),
                        color: AppColors.primaryElement,
                        shape: RoundedRectangleBorder(
                          borderRadius: Radii.k10pxRadius,
                        ),
                        textColor: Color.fromARGB(255, 112, 112, 112),
                        padding: EdgeInsets.all(0),
                        child: Text(
                          "SEARCH",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontFamily: "Helvetica Neue",
                            fontWeight: FontWeight.w400,
                            fontSize: 9,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 40,
                      height: 29,
                      margin: EdgeInsets.only(top: 8),
                      child: FlatButton(
                        onPressed: () => this.onCancelButtonPressed(context),
                        color: AppColors.primaryElement,
                        shape: RoundedRectangleBorder(
                          borderRadius: Radii.k10pxRadius,
                        ),
                        textColor: Color.fromARGB(255, 112, 112, 112),
                        padding: EdgeInsets.all(0),
                        child: Text(
                          "CANCEL",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontFamily: "Helvetica Neue",
                            fontWeight: FontWeight.w400,
                            fontSize: 9,
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