import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Welcome extends StatefulWidget {
  WelcomeState createState() {
    return WelcomeState();
  }
}

class WelcomeState extends State<Welcome> {

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body:  SafeArea(
        child: Center(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Container(
                  height: 200.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/logo.png'),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              ListTile(
                title: Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: TypewriterAnimatedTextKit(
                    speed: Duration(seconds: 1),
                    text:['face2pay'],
                    textAlign: TextAlign.center,
                    textStyle: TextStyle(
                      color: Color(0xFF1F3458),
                      fontFamily: 'Pacifico',
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.5, 
                    ),
                  ),   
                ),
              ),
              Container(
                child: Text('welcome',
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
              SizedBox(height: 20.0),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1.0,),
                ),
                child: Material(
                  elevation: 5.0,
                  color: Color(0xFFEB1555),
                  child: MaterialButton(
                    onPressed: () {Navigator.pushNamed(context, '/signin');},
                    minWidth: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    child: Text("Already a user?Sign in",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFEB1555), width: 1.0,),
                ),
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
                width: 200.0,
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(5.0),
                  child: MaterialButton(
                    onPressed: () {Navigator.pushNamed(context, '/signup');},
                    minWidth: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    child: Text("New on face2pay?Sign up",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFEB1555),
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),  
              ),
            ],
          ),
        ),
      ),
    );
  }
}

