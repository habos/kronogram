import 'package:flutter/material.dart';
import 'package:kronogram/UI_pages/values/values.dart';

class testPost extends StatelessWidget {
  testPost({this.plat, this.username, this.action});
  final String plat;
  final String username;
  final String action;

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 250,
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        borderRadius: Radii.k10pxRadius,
      ),

      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 20,
                margin: EdgeInsets.only(left: 10, top: 10),
                child: Text(
                  "$plat",
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
                  "- $username -",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                height: 20,
                margin: EdgeInsets.only(left: 10, top: 10, right: 140),
                child: Text(
                  " $action ",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 150,
            margin: EdgeInsets.only(left: 10, top: 10),
            decoration: BoxDecoration(
              color: AppColors.placeholderBackground,
              borderRadius: Radii.k10pxRadius,
            ),
          ),
        ],
      ),
    );
  }
}
