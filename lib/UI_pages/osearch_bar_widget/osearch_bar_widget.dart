
import 'package:flutter/material.dart';
import 'package:kronogram/UI_pages/search_results_widget/search_results_widget.dart';
import 'package:kronogram/UI_pages/values/values.dart';


class OSearchBarWidget extends StatelessWidget {
  
  void onCancelButtonPressed(BuildContext context) => Navigator.pop(context);
  
  void onSearchButtonPressed(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (context) => SearchResultsWidget()));
  
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 227, 228, 232),
          border: Border.all(
            width: 1,
            color: Color.fromARGB(255, 112, 112, 112),
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 214,
              height: 33,
              margin: EdgeInsets.only(left: 3, top: 1),
              decoration: BoxDecoration(
                color: Color.fromARGB(128, 255, 255, 255),
                borderRadius: Radii.k10pxRadius,
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "type username…",
                  contentPadding: EdgeInsets.all(0),
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontFamily: "Helvetica Neue",
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
                maxLines: 1,
                autocorrect: false,
              ),
            ),
            Spacer(),
            Container(
              width: 51,
              height: 29,
              margin: EdgeInsets.only(top: 2, right: 2),
              child: FlatButton(
                onPressed: () => this.onSearchButtonPressed(context),
                color: AppColors.primaryElement,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Color.fromARGB(255, 204, 205, 209),
                    width: 2,
                    style: BorderStyle.solid,
                  ),
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
                    fontSize: 11,
                  ),
                ),
              ),
            ),
            Container(
              width: 30,
              height: 29,
              margin: EdgeInsets.only(top: 2, right: 3),
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
                    fontSize: 7,
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