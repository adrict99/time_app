import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:time_app/screens/homepage.dart';


import 'welcome/welcome.dart';
import 'welcome/login.dart';
import 'welcome/register.dart';

import 'screens/timeline.dart';
import 'screens/calendar.dart';
import 'screens/productivity.dart';
import 'screens/notes.dart';
import 'screens/lists.dart';

void main() => runApp(TimeApp());

class TimeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      initialRoute: 'welcome_acs',
      routes: {
        'welcome_acs' : (context) => Welcome(),
        'login_acs' : (context) => Login(),
        'register_acs' : (context) => Register(),
        'homepage_screen' : (context) => HomePage(),
        'timeline_screen' : (contect) => Timeline(),
        'calendar_screen' : (context) => Calendar(),
        'productivity_screen' : (context) => Productivity(),
        'notes_screen' : (context) => Notes(),
        'lists_screen' : (context) => Lists(),
      },
    );
  }
}
