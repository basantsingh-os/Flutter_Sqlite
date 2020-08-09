import 'package:flutter/material.dart';

import 'Pages/Login/login_page.dart';
import 'Pages/home_page.dart';

void main() => runApp(MyApp());

final routes = {
  '/login':(BuildContext context)=>new LoginPage(),
  '/home':(BuildContext context)=>new HomePage(),
  '/':(BuildContext context)=>new LoginPage(),

};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext build) {
    return MaterialApp(
      title:"Sqlite App",
      theme:new ThemeData(primarySwatch: Colors.teal),
      routes:routes,
      
    );
  }
}

