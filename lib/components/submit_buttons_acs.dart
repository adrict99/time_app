import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  SubmitButton(this.texto, this.onPSbm);
  String texto;
  Function onPSbm;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(15.0),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: onPSbm,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            texto,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
