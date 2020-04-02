import 'package:flutter/material.dart';
import 'package:kronogram/models/krono_post.dart';

class Timeline extends StatefulWidget{
  Timeline({Key key})
      :super(key:key);


  @override
  State<StatefulWidget> createState(){
    return _TimelineState();
  }
}

class _TimelineState extends State<Timeline>{
  List<KronoPost> timelinePosts = List();

  void nickMethod() async{
    //TODO: Can't have an async initState so async work must be done here and assigned to local vars
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("made it");
    nickMethod();
  }

  @override
  Widget build(BuildContext context) {

    //TODO: Wants list is made you can uncomment this and delete the empty container
    /*
    ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: timelinePosts.length,
        itemBuilder: (BuildContext context, int index) {
          return timelinePosts[index].createPostWidget();
        }
    );

     */

    return Container(
      color: Colors.white,
    );
  }
}



class PlaceholderWidget extends StatelessWidget {
  final Color color;

  PlaceholderWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}
