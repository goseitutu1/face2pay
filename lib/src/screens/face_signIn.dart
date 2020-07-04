import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';

class FaceSignIn extends StatefulWidget {
  FaceSignInState createState() {
    return FaceSignInState();
  }
}

class FaceSignInState extends State<FaceSignIn> {

  final picker = ImagePicker();

  Future _getImage() async {
    var _pickedImage = await picker.getImage(source: ImageSource.camera);
    
  setState(() {
      File _image = File(_pickedImage.path);
      print('image: $_image');
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _getImage,
        backgroundColor: Color(0xFFEB1555),
        child: Icon(Icons.add_a_photo,color: Colors.black)
      ),
      body: Card(
        elevation: 5.0,
        margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Center(
          child: Text('Take a face picture')
        ),
      ),
    );
  }

}
    