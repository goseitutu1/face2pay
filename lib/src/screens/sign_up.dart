import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';
import 'dart:io';
import '../blocs/sign_up_bloc.dart';
import '../widgets/material_button.dart';
import '../widgets/text_feild.dart';
import '../widgets/facial_icon.dart';

class SignUp extends StatefulWidget {
  SignUpState createState() {
    return SignUpState();
  }
}

class SignUpState extends State<SignUp> {

  final picker = ImagePicker();
  bool  _imageUploaded = false;
  String _downloadImageURL;
  bool _showSpinner = false; 
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  StorageReference _reference = FirebaseStorage.instance.ref().child(signUpBloc.regImage.toString());

  Future _getImage() async {
    var _pickedImage = await picker.getImage(source: ImageSource.camera);
    
  setState(() {
      signUpBloc.regImage = File(_pickedImage.path);
      print('image: $signUpBloc.regImage');
    });
    // _image;
    // String _email = signUpBloc.getEmail();
  }

  Future _uploadImage() async {
    StorageUploadTask uploadTask = _reference.putFile(signUpBloc.regImage);
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

  // Future _downloadImageURL() async {
  //   String _downloadAddress = await _reference.getDownloadURL();

  //   setState(() {
  //     _downloadImageURL = _downloadAddress;
  //   });
  // }

  Widget build(BuildContext context){
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner, 
        child: ListView(
        padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 20.0),
        children: <Widget>[
          Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 300.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/logo.png'), 
                        fit: BoxFit.fill),
                      ),
                  ),
                  ListTile(
                  title: Text('Sign Up',
                    textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.red,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                        letterSpacing: 1.5,
                      ),
                    ), 
                  ),
                  SizedBox(height: 10.0),
                  _emailFeild(context),
                  SizedBox(height: 30.0),
                  _passwordFeild(context),
                  SizedBox(height: 30.0),
                  _confirmPasswordFeild(context),
                  SizedBox(height: 20.0),
                  ListTile(
                    onTap:  _getImage,
                    title: FacialIcon(description: 'Register face'),
                  ),
                  SizedBox(height: 10.0),
                  Divider(thickness: 1.0),
                  signUpBloc.regImage == null ? Container() :
                  Button(
                    description: 'Sign up',
                    onPressed: () async {
                      setState(() {
                        _showSpinner = true;
                      });
                      _uploadImage();
                      _imageUploaded == false ? print('progress') :
                      setState(() {
                        _showSpinner = false;
                      });

                      // String _email = signUpBloc.getEmail();
                      // String _password = signUpBloc.getPassword();
                      // String _confirmPassword = signUpBloc.getConfirmPassword();
                      // if(_password == _confirmPassword){
                      // setState(() {
                      //   _showSpinner = true;
                      // });
                      // try{
                      //   final _auth = FirebaseAuth.instance;
                      //   final response = await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
                      //   if(response != null){
                      //     Navigator.pushNamed(context, '/home');
                      //   }
                      //   setState((){
                      //     _showSpinner = false;
                      //   });
                      // }
                      // catch(e){
                      //   setState((){
                      //     _showSpinner = false;
                      //   });
                      //   String errorMessage = e.toString().substring(24,44);
                      //   _scaffoldKey.currentState.showSnackBar(
                      //     SnackBar(
                      //       backgroundColor: Colors.red,
                      //       content: Text(
                      //         '$errorMessage',
                      //         style: TextStyle(
                      //           color: Colors.black,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //     ),
                      //   );
                      // }
                     }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emailFeild(BuildContext context) {
    return StreamBuilder(
      stream: signUpBloc.emailStream,
      builder: (context, AsyncSnapshot<String> snapshot) {
        return TextFeild(
          onChanged: signUpBloc.changeEmail,
          errorText: snapshot.error,
          obscureText: false,
          hintText: 'Email',
          icon: Icon(Icons.email)
        );
      } 
    );
  }

  Widget _passwordFeild(BuildContext context) {
     return StreamBuilder(
      stream: signUpBloc.passwordStream,
      builder: (context, AsyncSnapshot<String> snapshot) {
        return TextFeild(
          onChanged: signUpBloc.changePassword,
          errorText: snapshot.error,
          obscureText: true,
          hintText: 'Password',
          icon: Icon(Icons.enhanced_encryption)
        );
      }
    );
  }

  Widget _confirmPasswordFeild(BuildContext context) {
     return StreamBuilder(
      stream: signUpBloc.confirmPasswordStream,
      builder: (context, AsyncSnapshot<String> snapshot) {
        return TextFeild(
          onChanged: signUpBloc.changeConfirmPassword,
          errorText: snapshot.error,
          obscureText: true,
          hintText: 'Confirm Password',
          icon: Icon(Icons.enhanced_encryption)
        );
      }
    );
  }
}
