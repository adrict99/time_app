import 'package:flutter/material.dart';

class ExitButton extends StatelessWidget {

  ExitButton(this.onPeXit);

  Function onPeXit;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.exit_to_app,
        color: Colors.white,
        size: 28.0,
      ),
      onPressed: onPeXit,
    );
  }
}

class appBarTitle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Text('Time App',
      style:
      TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
