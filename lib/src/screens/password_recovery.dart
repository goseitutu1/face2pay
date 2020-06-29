import 'package:flutter/material.dart';
import '../widgets/material_button.dart';
import '../widgets/text_feild.dart';
import '../blocs/password_recovery_bloc.dart';

class PasswordRecovery extends StatelessWidget {

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Password recovery',
        style: TextStyle(
            color: Colors.black,
            fontFamily: 'Montserrat',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
      ),
      body:Container(
        margin: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 30.0,),
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text(
                'Please type in your email. We will send you a link to change the password',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              )
            ),
            SizedBox(height: 20.0),
            StreamBuilder(
              stream: passwordRecoveryBloc.emailStream,
              builder: (context, AsyncSnapshot<String> snapshot) {
                return TextFeild(
                  obscureText: false,
                  onChanged: passwordRecoveryBloc.changeEmail,
                  hintText: 'Email',
                  icon: Icon(Icons.email),
                  errorText: snapshot.error,
                );
              }
            ),
            Divider(thickness: 1.0,),
            SizedBox(height: 20.0),
            Button(description: 'Submit', onPressed: () {print(passwordRecoveryBloc.getEmail());},)
          ]
        ),
      ),
    );
  }

}