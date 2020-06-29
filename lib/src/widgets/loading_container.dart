import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget{

  Widget build(BuildContext context){
    return ListTile(
      title: Container(
        color: Colors.grey[200],
        height: 24.0,
        width: 150.0,
        margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
      ) 
    );
  }
} 