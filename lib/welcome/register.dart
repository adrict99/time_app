import 'package:flutter/material.dart';

import 'package:time_app/components/textfields_styles.dart';
import 'package:time_app/components/submit_buttons_acs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:time_app/screens/homepage.dart';
import 'package:time_app/screens/timeline.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Register extends StatefulWidget {
  static const String id = 'register_acs';
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String emailReg;
  String passwordReg;

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
              TextFieldStyled('Correo electrónico',
                  (value) {
                    emailReg = value;
                  },
                false,
                TextInputType.emailAddress,
              ),
              SizedBox(
                height: 8.0,
              ),
              TextFieldStyled('Contraseña',
                  (value) {
                    passwordReg = value;
                  },
                true,
                TextInputType.text,
              ),
              SizedBox(
                height: 20.0,
              ),
              SubmitButton('Registrar',
                    () async {
                setState(() {
                  showSpinner = true;
                });
                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      email: emailReg, password: passwordReg);
                  if(newUser != null) {
                    Navigator.pushNamed(context, HomePage.id);
                  }
                  setState(() {
                    showSpinner = false;
                  });
                }
                catch (e) {
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
