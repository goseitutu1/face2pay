import 'package:flutter/material.dart';


class FacialRecognition extends StatelessWidget{
  final String description;

  FacialRecognition({this.description});

  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
            image: AssetImage('images/face.jpg'), height: 100.0,
          ),
          Text( description,
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.black,
              fontSize: 15.0,
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  } 
}