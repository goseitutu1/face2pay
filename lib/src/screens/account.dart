import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import '../blocs/home_bloc.dart';
import '../blocs/account_bloc.dart';
import '../models/user_contact.dart';
import '../models/username.dart';
import '../widgets/loading_container.dart';
import '../widgets/material_button.dart';
import '../widgets/text_feild.dart';


class Account extends StatefulWidget {
  AccountState createState() {
    return AccountState();
  }
}

class AccountState extends State<Account> {

  final picker = ImagePicker();

  Future _getImage() async {
    var _pickedImage = await picker.getImage(source: ImageSource.gallery);
    
  setState(() {
      accountBloc.image = File(_pickedImage.path);
      print('image: $accountBloc.image');
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ACCOUNT',
        style: TextStyle(
            color: Colors.black,
            fontFamily: 'Montserrat',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
      ),
      body: Card(
        elevation: 5.0,
        margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: ListView(
          children: <Widget>[
            _profileTile(context),
            _userNameTile(context),
            Divider(thickness: 1.0,),
            _contactTile(context),
            Divider(thickness: 1.0,),
            _transactionTile(context),
            Divider(thickness: 1.0,),
            // _walletTile(context),
            Divider(thickness: 1.0,),
          ],
        ),
      ),
    );
  }

  Widget _profileTile(BuildContext context){
    Future<String> _user = homeBloc.getUser(); 
    return Container(
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      width: MediaQuery.of(context).size.width,
      height: 200.0,
      color:  Color(0xFFEB1555),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Stack(
            children: <Widget>[
              CircleAvatar(
                radius: 35.0,
                backgroundColor: Colors.grey,
                backgroundImage: accountBloc.image == null ? null : FileImage(accountBloc.image),
              ),
              Positioned(
                right: 32.0,
                top: 32.0,
                child: IconButton(
                  onPressed: _getImage,
                  icon: Icon(Icons.add_a_photo,color: Colors.black),
                ),
              ),
            ]
          ),
          FutureBuilder(
            future: _user,
            builder: (context, AsyncSnapshot<String> snapshot){
              return ListTile(
                title: Text('${snapshot.data}',textAlign: TextAlign.center,style: TextStyle(color: Colors.black)),
              );
            }
          ),                 
        ],
      ),
    );
  }

  Widget _userNameTile(BuildContext context){
    accountBloc.fetchUsername(3);
    return StreamBuilder(
      stream: accountBloc.usernameModelStream,
      builder: (context, AsyncSnapshot<Future<UserNameModel>> snapshot){
        if(!snapshot.hasData){
          return LoadingContainer();
        }
        return FutureBuilder(
          future: snapshot.data,
          builder: (context, AsyncSnapshot<UserNameModel> usersnapshot){
            if(!usersnapshot.hasData){
              return ListTile(
              title: Text(
                'Username',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                  ),
                ),
              trailing: Icon(Icons.edit,color: Colors.red),
              onTap: (){
                _usernameAletDialog(context, 'Your name');
              },
            );
            }
            return ListTile(
              title: Text(
                '${usersnapshot.data.username}',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                  ),
              ),
              trailing: Icon(Icons.edit,color: Colors.red),
              onTap: (){
                _usernameAletDialog(context, 'Your name');
              },
            );
          },
        );
      },
    );
  }
  
  Widget _contactTile(BuildContext context){
    accountBloc.fetchUsercontact(3);
    return StreamBuilder(
      stream: accountBloc.usercontactModelStream,
      builder: (context, AsyncSnapshot<Future<UserContactModel>> snapshot){
        if(!snapshot.hasData){
          return LoadingContainer();
        }
        return FutureBuilder(
          future: snapshot.data,
          builder: (context, AsyncSnapshot<UserContactModel> usercontactsnapshot){
            if(!usercontactsnapshot.hasData){
             return ListTile(
              title: Text(
                'Contact',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
              trailing: Icon(Icons.edit,color: Colors.red),
              onTap: (){
                _userContactAletDialog(context, 'Your contact');
              },
            );
            }
            return ListTile(
              title: Text(
                '${usercontactsnapshot.data.contact}',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
              trailing: Icon(Icons.edit,color: Colors.red),
              onTap: (){
                _userContactAletDialog(context, 'Your contact');
              },
            );
          }
        );
      }
    );
  }

  Widget _transactionTile(BuildContext context){
    return ListTile(
      onTap: (){Navigator.pushNamed(context, '/transaction');},
      title: Text(
        'Transaction history',
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'Montserrat',
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.0,
        ),
      ),
      trailing: Icon(Icons.view_list,color: Colors.red),
    );
  }

  // Widget _walletTile(BuildContext context){
  //   return ListTile(
  //     title: Text(
  //       'My wallet',
  //       style: TextStyle(
  //         color: Colors.black,
  //         fontFamily: 'Montserrat',
  //         fontSize: 15.0,
  //         fontWeight: FontWeight.bold,
  //         letterSpacing: 1.0,
  //       ),
  //     ),
  //     trailing: Text('\$ 0.0'),
  //   );
  // }

  Future<Widget> _usernameAletDialog(BuildContext context, String title){
    return showDialog(
      context: context,
      builder: (context) {
        return StreamBuilder(
          stream: accountBloc.nameStream,
          builder: (context, AsyncSnapshot<String> snapshot){
            return AlertDialog(
              title: Text('$title'),
              content: TextFeild( 
                icon: Icon(Icons.edit),
                errorText: null,
                obscureText: false,
                hintText: 'Type here',
                onChanged: accountBloc.nameInStream,
              ),
              actions: <Widget>[
                Button(
                  description: 'Submit',
                  onPressed: (){
                    print('submit');
                    accountBloc.updateUsername();
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(height: 10.0),
                Button(
                  description: 'Cancel',
                  onPressed: (){Navigator.of(context).pop();},
                ),
              ],
            );
          }
        );
      }
    );
  }

   Future<Widget> _userContactAletDialog(BuildContext context, String title){
    return showDialog(
      context: context,
      builder: (context) {
        return StreamBuilder(
          stream: accountBloc.contactStream,
          builder: (context, AsyncSnapshot<String> snapshot){
            return AlertDialog(
              title: Text('$title'),
              content: TextFeild( 
                icon: Icon(Icons.edit),
                errorText: snapshot.error,
                obscureText: false,
                hintText: 'Type here',
                onChanged: accountBloc.contactInStream,
              ),
              actions: <Widget>[
                Button(
                  description: 'Submit',
                  onPressed: (){
                    print('submit');
                    accountBloc.updateUserContact();
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(height: 10.0),
                Button(
                  description: 'Cancel',
                  onPressed: (){Navigator.of(context).pop();},
                ),
              ],
            );
          }
        );
      }
    );
  }
}