
import 'package:flutter/material.dart';
import 'package:kronogram/UI_pages/values/colors.dart';
import 'package:kronogram/UI_pages/values/radii.dart';
import 'package:kronogram/utils/date_utils.dart';

class TwitterPostView extends StatelessWidget {
  final Widget _tweetWidget;
  final DateTime _date;

  TwitterPostView.fromTweetWidget(Widget w, DateTime date)
    : _tweetWidget = w,
      _date = date;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container (
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        borderRadius: Radii.k10pxRadius,
      ),
      child: Column(
        children: [ Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 20,
              margin: EdgeInsets.only(left: 10, top: 10),
              child: Text(
                "Twitter",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ),
            Spacer(),
            Container(
              height: 20,
              margin: EdgeInsets.only(left: 10, top: 10, right: 10),
              child: Text(
                getDateString(_date),
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            )
          ],
        ),
          _tweetWidget,
        ],
      ),
    );
  }
}