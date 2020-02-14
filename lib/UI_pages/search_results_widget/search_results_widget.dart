
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
              top: 38,
              child: Container(
                width: 339,
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
              top: 60,
              right: 9,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        height: 583,
                        margin: EdgeInsets.only(top: 46),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(242, 225, 226, 230),
                          border: Border.fromBorderSide(Borders.primaryBorder),
                          borderRadius: Radii.k10pxRadius,
                        ),
                        child: Container(),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 30,
                      height: 30,
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
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "search username",
                          contentPadding: EdgeInsets.all(0),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        autocorrect: false,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 40,
                      height: 29,
                      margin: EdgeInsets.only(right: 2),
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
                      margin: EdgeInsets.only(right: 4),
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
            Positioned(
              left: 18,
              top: 123,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 25,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.only(top: 13),
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
                        ),
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "search results…",
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
                      ],
                    ),
                  ),
                  Container(
                    height: 469,
                    margin: EdgeInsets.only(top: 16),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          left: 14,
                          top: 0,
                          child: Image.asset(
                            "assets/images/path-1.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 5,
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
          ],
        ),
      ),
    );
  }
}