import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kronogram/UI_pages/values/colors.dart';
import 'package:kronogram/UI_pages/values/radii.dart';
import 'package:kronogram/models/krono_post.dart';
import 'package:kronogram/utils/date_utils.dart';

class postView extends StatelessWidget {
  final String _username;
  final KronoPost _post;

  postView(KronoPost this._post, [String this._username]);

  Widget _usernameWidget() {
    if(_username == null)
      return Container();
    else return Container(
      height: 20,
      margin: EdgeInsets.only(left: 10, top: 10, right: 40),
      child: Text(
        "- $_username -",
        textAlign: TextAlign.left,
        style: TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
          fontWeight: FontWeight.w400,
          fontSize: 14
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color platformBorderColor;
    String platform = EnumToString.parseCamelCase(_post.getPlatform());
    if(platform == 'Facebook') platformBorderColor = AppColors.facebookColor;
    else if(platform == 'Twitter') platformBorderColor = AppColors.twitterColor;
    else if(platform == 'Instagram') platformBorderColor = AppColors.instagramColor;
    else platformBorderColor = Colors.white;
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: platformBorderColor,
        borderRadius: Radii.k10pxRadius,
        border: Border.all(color: platformBorderColor, width: 2),
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
                platform,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ),
            Spacer(),
            _usernameWidget(),
            Container(
              height: 20,
              margin: EdgeInsets.only(left: 10, top: 10, right: 10),
              child: Text(
                getDateString(_post.getCreationTime().toLocal()),
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
          _post.createPostWidget(),
        ],
      ),
    );
  }
}