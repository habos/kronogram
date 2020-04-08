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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
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
                EnumToString.parseCamelCase(_post.getPlatform()),
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
                getDateString(_post.getCreationTime()),
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
          _post.createPostWidget()
        ],
      ),
    );
  }
}