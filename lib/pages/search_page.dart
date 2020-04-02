import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kronogram/services/globals.dart' as globals;
import 'package:kronogram/services/database.dart';

import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flutter/material.dart';

class SearchUser {
  final String title;

  SearchUser(this.title);
}

class SearchPage extends StatefulWidget {

  final Database db = globals.db;
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchBarController<SearchUser> _searchBarController = SearchBarController();
  bool isReplay = false;
  List<SearchUser> usernames = List();
  List<SearchUser> filteredList = List();

  void makeUsernameList() async{
    QuerySnapshot allUsers = await widget.db.getUsernames();
    setState(() {
      allUsers.documents.forEach((item){
        usernames.add(SearchUser(item.data.remove('username')));
      });
    });
  }

  void initState(){
    super.initState();
    makeUsernameList();
  }


  Future<List<SearchUser>> _searchList(String _searchText) async{

    filteredList.clear();

    for (int i = 0; i < usernames.length-1; i++) {
      if (usernames[i].title.contains(_searchText) && usernames[i].title != null) {
        filteredList.add(SearchUser(usernames[i].title));
      }
    }

    return filteredList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SearchBar<SearchUser>(
          searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
          headerPadding: EdgeInsets.symmetric(horizontal: 20),
          listPadding: EdgeInsets.symmetric(horizontal: 20),
          onSearch: _searchList,
          searchBarController: _searchBarController,
          placeHolder: Text("placeholder"),
          cancellationWidget: Text("Cancel"),
          emptyWidget: Text("empty"),
          header: Row(
            children: <Widget>[
              RaisedButton(
                child: Text("Sort"),
                onPressed: () {
                  _searchBarController.sortList((SearchUser a, SearchUser b) {
                    return a.title.compareTo(b.title);
                  });
                },
              ),
              RaisedButton(
                child: Text("Desort"),
                onPressed: () {
                  _searchBarController.removeSort();
                },
              ),
              RaisedButton(
                child: Text("Replay"),
                onPressed: () {
                  isReplay = !isReplay;
                  _searchBarController.replayLastSearch();
                },
              ),
            ],
          ),
          onCancelled: () {
            print("Cancelled triggered");
          },
          mainAxisSpacing: 10,
          onItemFound: (SearchUser post, int index) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 2.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                ),
              ),
              child: ListTile(
                title: Text(post.title),
                onTap: () {
                  print(index);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class Detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            Text("Detail"),
          ],
        ),
      ),
    );
  }
}