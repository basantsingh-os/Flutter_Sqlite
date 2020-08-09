import 'package:flutter/material.dart';
import 'package:flutter_sqlite/Model/User.dart';
import 'package:flutter_sqlite/data/database_helper.dart';

import 'login_presenter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginPageContract {
  BuildContext _ctx;
  bool _isLoading;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _username, _password;

  LoginPagePresenter _presenter;

  _LoginPageState() {
    _presenter = new LoginPagePresenter(this);
  }

  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _presenter.doLogin(_username, _password);
      });
    }
  }

  void _showSnackbar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    var LoginBtn = new RaisedButton(
        onPressed: _submit, child: new Text("Login"), color: Colors.green);

    var loginForm = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Text(
          "Sqlite login",
          textScaleFactor: 2.0,
        ),
        new Form(
            key: formKey,
            child: new Column(children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(10),
                child: new TextFormField(
                  onSaved: (val) => _username = val,
                  decoration: new InputDecoration(labelText: "Username"),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10),
                child: new TextFormField(
                  onSaved: (val) => _username = val,
                  decoration: new InputDecoration(labelText: "Password"),
                ),
              )
            ])),
        LoginBtn
      ],
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Login Page"),
      ),
      key: scaffoldKey,
      body: new Container(child: new Center(child: loginForm)),
    );
  }

  @override
  void onLoginError(String error) {
    _showSnackbar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onLoginSuccess(User user) async {
    _showSnackbar(user.toString());
    setState(() {
      _isLoading = false;
    });
    var db = new DataBaseHelper();
    await db.saveUser(user);
    Navigator.of(context).pushNamed("/home");
  }
}
