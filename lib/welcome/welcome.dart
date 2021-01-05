import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:time_app/components/log_reg_buttons.dart';
import 'package:time_app/welcome/login.dart';
import 'package:time_app/welcome/register.dart';

class Welcome extends StatefulWidget {
  static const String id = 'welcome_acs';

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print('ok');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset('assets/time_logo.gif'),
                  height: 180.0,
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Log_reg_button(
              Text('Acceso'), () {
                Navigator.pushNamed(context, Login.id);
              },
            ),
            Log_reg_button(
              Text('Registro'), () {
                Navigator.pushNamed(context, Register.id);
              }
            ),
          ],
        ),
      ),
    );
  }
}
