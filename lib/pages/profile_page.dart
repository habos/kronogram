import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kronogram/UI_pages/values/colors.dart';
import 'package:kronogram/pages/settings.dart';
import 'package:kronogram/services/authentication.dart';
import 'package:kronogram/services/database.dart';
import 'package:kronogram/services/globals.dart' as globals;

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.userId, this.logoutCallback}) : super(key: key);

  final BaseAuth auth = globals.auth;
  final Database db = globals.db;
  final String userId;
  final VoidCallback logoutCallback;

  @override
  State<StatefulWidget> createState() => new _ProfilePageState();

  void onBackPressed(BuildContext context) => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              SettingsPage(userId: userId, logoutCallback: logoutCallback)));
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = new GlobalKey<FormState>();
  final _usernameController = new TextEditingController();
  final _passwordController1 = new TextEditingController();
  String currentUsername;
  String newUsername;
  String newPassword;
  bool _isloading;
  //to change username, full name, email, password

  @override
  void initState() {
    // TODO: implement initState
    getCurrentInfo();
    _usernameController.text = currentUsername;
    _isloading = false;
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController1.dispose();
    super.dispose();
  }

  void getCurrentInfo() async {
    currentUsername = await widget.db.getUsername(widget.userId);
  }

  Widget showBackButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: AppColors.randomButton2,
            child: new Text('Go Back',
                style: new TextStyle(
                    fontSize: 20.0, color: AppColors.randomButtonText2)),
            onPressed: () => widget.onBackPressed(context),
          ),
        ));
  }

  Widget showUsernameInput() {
    return new Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        autofocus: false,
        controller: _usernameController,
        decoration: InputDecoration(
          labelText: 'Username',
        ),
        validator: (value) => value.isEmpty ? 'Username can\'t be empty' : null,
        onSaved: (value) => newUsername = value.trim(),
      ),
    );
  }

  Widget showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        controller: _passwordController1,
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
          labelText: 'New Password'
        ),
        onSaved: (value) => newPassword = value.trim(),
      ),
    );
  }

  Widget showConfirmPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            labelText: 'Confirm New Password'
        ),
        validator: (value) => (value.compareTo(_passwordController1.text) != 0 && value != null) ? 'Passwords must match' : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            showForm(),
          ],
        )
      ),
    );
  }

  Widget showForm() {
    return new Container(
      padding: EdgeInsets.all(16.0),
      child: new Form(
          key: _formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              showUsernameInput(),
              showPasswordInput(),
              showConfirmPasswordInput(),
              showSubmitButton(),
              showBackButton(),
            ],
          )
      ),
    );
  }

  Widget showSubmitButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: AppColors.randomButton2,
            child: new Text('Submit Changes',
                style: new TextStyle(
                    fontSize: 20.0, color: AppColors.randomButtonText2)),
            onPressed: () => validateAndSubmit()
          ),
        ));
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() {
    setState(() {
      _isloading = true;
    });
    if(validateAndSave()) {
      try {
        if(newUsername.length > 0 && newUsername != null) {
          widget.db.setUsername(widget.userId, newUsername);
        }
        if(newPassword.length > 0 && newPassword != null) {
          widget.auth.updateCurrentUserPassword(newPassword);
        }
        setState(() {
          _isloading = false;
        });
      } catch(e) {
          print('Error: $e');
          setState(() {
            _isloading = false;
          });
      }
    }
  }
}