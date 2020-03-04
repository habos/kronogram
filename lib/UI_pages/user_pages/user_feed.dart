import 'package:flutter/material.dart';
import 'package:kronogram/UI_pages/values/values.dart';

import 'package:kronogram/UI_pages/user_pages/user_test_post.dart';

import 'package:kronogram/UI_pages/my_app_bar/my_app_bar.dart';
import 'package:kronogram/UI_pages/display_posts/display_posts.dart';

class userFeed extends StatelessWidget{
  userFeed({Key key, bool today})
  :super(key:key);

  bool today;
  List<generalPost>postsList =userTestPost().getpostlists(5);
  String postDate;




  @override
  Widget build(BuildContext context) {
    checkDate(today);
      return Container(

        child:  ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: postsList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      //crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [

                        Text(
                          postDate,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        Container(
                          height: 1,
                          width: 320,
                          color: Colors.black,
                          margin:
                          const EdgeInsets.only(left: 10.0, right: 10.0),
                        ),
                      ],
                    ),
                    testPost(
                      plat: postsList[index].platform,
                      username: postsList[index].userPosted,
                      action:  postsList[index].action,
                    )
                  ]),
            );
          },
          separatorBuilder: (BuildContext context, int index) => Divider(
            color: Colors.black,
          ),

          //Divider(color: Colors.black,),
        ),



    );
  }
  void checkDate( bool today){
    if(today){
      postDate = "X years agou today";
    }
    else{
      postDate = "DATE:";
    }
  }
}





