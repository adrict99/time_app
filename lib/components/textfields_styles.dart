import 'package:flutter/material.dart';

class TextFieldStyled extends StatelessWidget {

  TextFieldStyled(this.hint, this.onChTxt, this.asters, this.tipotec);
  String hint;
  Function onChTxt;
  bool asters;
  TextInputType tipotec;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: tipotec,
      obscureText: asters,
      textAlign: TextAlign.center,
      onChanged: onChTxt,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
          BorderSide(
              color: Colors.black,
              width: 1.5
          ),
          borderRadius:
          BorderRadius.all(Radius.circular(15.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
          BorderSide(
            color: Colors.amber,
            width: 3.0,
          ),
          borderRadius: BorderRadius.all(Radius.circular(15.0),
          ),
        ),
      ),
    );
  }
}
