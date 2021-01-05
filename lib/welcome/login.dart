import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:time_app/components/textfields_styles.dart';
import 'package:time_app/components/submit_buttons_acs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:time_app/screens/homepage.dart';


class Login extends StatefulWidget {
  static const String id = 'login_acs';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String emailLog;
  String passwordLog;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        color: Colors.amber,
        opacity: 0.75,
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 200.0,
                child: Image.asset('assets/time_logo.png'),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextFieldStyled(
                'Correo electrónico',
                (value) {
                  emailLog = value;
                },
                false,
                TextInputType.emailAddress,
              ),
              SizedBox(
                height: 8.0,
              ),
              TextFieldStyled(
                'Contraseña',
                (value) {
                  passwordLog = value;
                },
                true,
                TextInputType.text,
              ),
              SizedBox(
                height: 20.0,
              ),
              SubmitButton(
                'Acceder',
                () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: emailLog, password: passwordLog);
                    if (user != null) {
                      Navigator.pushNamed(context,
                          HomePage.id); 
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
