import 'package:flutter/material.dart';

class TextFeild extends StatelessWidget{
  final onChanged;
  final errorText;
  final bool obscureText;
  final String hintText;
  final Widget icon;

  TextFeild({this.onChanged, this.errorText, this.obscureText,this.hintText,this.icon});

  Widget build(BuildContext context){
    return TextField(
      onChanged: onChanged,
      obscureText: obscureText,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'Montserrat',
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5,
      ),
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.all(0.0),
          child: icon,
        ),
        fillColor: Color(0xffF3F1F4),
        filled: true,
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: hintText,
        errorText: errorText,
        border: OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.circular(50.0))
      ),
    );
  }
}