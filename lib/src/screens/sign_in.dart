import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../blocs/sign_in_bloc.dart';
import '../widgets/text_feild.dart';
import '../widgets/facial_icon.dart';
import '../widgets/material_button.dart';

class SignIn extends StatefulWidget {
  SignInState createState() {
    return SignInState();
  }
}

class SignInState extends State<SignIn> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _showSpinner = false; 

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
                        fit: BoxFit.fill
                      )
                    ),
                  ),
                  ListTile(
                    title: Text('Sign In',
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
                  SizedBox(height: 20.0),
                  _passwordFeild(context),
                  ListTile(
                    onTap: () {Navigator.pushNamed(context, '/password_recovery');},
                    trailing: Text('Forgot Password?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.red,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ), 
                  ),
                  Divider(thickness: 1.0),
                  Button(
                    description: 'Sign in',
                    onPressed: () async {
                      String _email = signinBloc.getEmail();
                      String _password = signinBloc.getPassword();
                        if((_email.contains('@')) && (_password.length >= 6)){
                          setState(() {
                            _showSpinner = true;
                          });
                          try{
                            final _auth = FirebaseAuth.instance;
                            final response = await _auth.signInWithEmailAndPassword(email: _email, password: _password);
                            if(response != null){
                                Navigator.pushNamed(context, '/home');
                            }
                            setState(() {
                              _showSpinner = false;
                            });
                          }
                          catch(e){
                            setState(() {
                              _showSpinner = false;
                            });
                            String _errorMessage = e.toString().substring(24,49);
                            _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                  '$_errorMessage',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          }
                        }
                        else{
                           _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                  'Invalid inputs',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                        }
                    }
                  ),
                  SizedBox(height: 5.0),
                  ListTile(
                    onTap: () async {
                      print('face');
                    },
                    title: FacialIcon(description: 'Use facial recognition'),
                  ),
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }

  Widget _emailFeild(BuildContext context) {
    return StreamBuilder(
      stream: signinBloc.emailStream,
      builder: (context, AsyncSnapshot<String> snapshot) {
        return TextFeild(
          onChanged: signinBloc.changeEmail, 
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
      stream: signinBloc.passwordStream,
      builder: (context, AsyncSnapshot<String> snapshot) {
        return TextFeild(
          onChanged: signinBloc.changePassword, 
          errorText: snapshot.error, 
          obscureText: true,
          hintText: 'Password',
          icon: Icon(Icons.enhanced_encryption)
        );
      }
    );
  }

}
