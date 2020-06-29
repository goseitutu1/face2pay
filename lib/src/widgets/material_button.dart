import 'package:flutter/material.dart';

class Button extends StatelessWidget{
  final Function onPressed;
  final String description;

  Button({this.onPressed, this.description});

  Widget build(BuildContext context) {
    return  Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(5.0),
      color: Color(0xFFEB1555),
      child: MaterialButton(
        onPressed: onPressed,
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        child: Text( description,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Montserrat',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }
}