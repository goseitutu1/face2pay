import 'package:flutter/material.dart';
import '../blocs/sign_up_bloc.dart';

class FacialIcon extends StatelessWidget{
  final String description;

  FacialIcon({this.description});
//  accountBloc.image == null ? null : FileImage(accountBloc.image),
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
            image: signUpBloc.regImage != null ?  FileImage(signUpBloc.regImage): AssetImage('images/face.jpg'), height: 100.0,
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