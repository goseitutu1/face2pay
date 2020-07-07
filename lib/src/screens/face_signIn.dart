import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:async';
import 'dart:io';
import '../blocs/sign_in_bloc.dart';
import '../widgets/material_button.dart';

class FaceSignIn extends StatefulWidget {
  FaceSignInState createState() {
    return FaceSignInState();
  }
}

class FaceSignInState extends State<FaceSignIn> {

  bool  _imageUploaded = false;
  String _downloadImageURL;
  bool _showSpinner = false; 
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  StorageReference _reference = FirebaseStorage.instance.ref().child(signinBloc.image.toString());
  final picker = ImagePicker();

  Future _getImage() async {
    var _pickedImage = await picker.getImage(source: ImageSource.camera);
    
  setState(() {
      signinBloc.image = File(_pickedImage.path);
      print('image: ${signinBloc.image}');
    });
  }

  Future _uploadImage() async {
    StorageUploadTask uploadTask = _reference.putFile(signinBloc.image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    setState(() {
      _imageUploaded = true;
    });
    print('taskSnapshot: $taskSnapshot');
    String _downloadAddress = await _reference.getDownloadURL();
    setState(() {
      _downloadImageURL = _downloadAddress;
    });
    print('imageurl: $_downloadImageURL');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('FACIAL RECOGNITION',
        style: TextStyle(
            color: Colors.black,
            fontFamily: 'Montserrat',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImage,
        backgroundColor: Color(0xFFEB1555),
        child: Icon(Icons.add_a_photo,color: Colors.black)
      ),
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner, 
        // child: Card(
        //   margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        //   elevation: 5.0,
          child: Container(
            margin: EdgeInsets.fromLTRB(30.0,30.0,30.0,30.0),
            width: 300.0,
            height: 20.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(width: 1.0, color: Colors.grey)
            ),
            child: Center(
              child: Column(
                children: <Widget>[
                  signinBloc.image == null ? Text('Take a face picture') : FileImage(signinBloc.image),
                  SizedBox(height: 20.0),
                  signinBloc.image == null ? SizedBox() : 
                  Button(
                    onPressed: () { 
                      _uploadImage();
                      setState(() {
                        _showSpinner = true;
                      });
                      _imageUploaded == false ? print('progress') :
                      setState(() {
                        _showSpinner = false;
                      });
                    },
                    description: 'verify face'
                  ),
                ],
              ),
            ),
          ),
        //),
      ),
    );
  }

}
    