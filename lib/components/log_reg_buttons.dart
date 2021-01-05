import 'package:flutter/material.dart';

class Log_reg_button extends StatelessWidget {

  Log_reg_button(this.texto, this.onP_wel);
  Text texto;
  Function onP_wel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: Colors.amber,
        borderRadius: BorderRadius.circular(15.0),
        child: MaterialButton(
          onPressed: onP_wel,
          minWidth: 200.0,
          height: 42.0,
          child: texto,
        ),
      ),
    );
  }
}