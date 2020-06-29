import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'dart:io';
import '../models/username.dart';
import '../models/user_contact.dart';
import '../providers/user_db.dart';

class AccountBloc{

  File image;
  final _usernameController = BehaviorSubject<Future<UserNameModel>>(); 
  Stream<Future<UserNameModel>> get usernameModelStream => _usernameController.stream;
  Sink<Future<UserNameModel>> get _usernameModel => _usernameController.sink;

  fetchUsername(int id) {
    _usernameModel.add(userDbProvider.fetchUserName(id));
  }

  final _usercontactController = BehaviorSubject<Future<UserContactModel>>(); 
  Stream<Future<UserContactModel>> get usercontactModelStream => _usercontactController.stream;
  Sink<Future<UserContactModel>> get _usercontactModel => _usercontactController.sink;

  fetchUsercontact(int id) {
    _usercontactModel.add(userDbProvider.fetchUserContact(id));
  }

  final _userInputController = BehaviorSubject<String>(); 
  Stream<String> get nameStream => _userInputController.stream;
  Function(String) get nameInStream => _userInputController.sink.add;

  updateUsername(){
    final _username = _userInputController.value;
    UserNameModel _userModel = UserNameModel(username: _username);
    userDbProvider.updateUserName(_userModel, 3);
    fetchUsername(3);
  }

  final _contactInputController = BehaviorSubject<String>(); 
  Stream<String> get contactStream => _contactInputController.stream.transform(_contactValidator);
  Function(String) get contactInStream => _contactInputController.sink.add;

  final _contactValidator = StreamTransformer<String,String>.fromHandlers(
    handleData: (character,sink){
      if(character.length == 10)
      sink.add(character);
      else
      sink.addError('must be 10 digits.');
    }
  );

  updateUserContact(){
    final _contact = _contactInputController.value;
    UserContactModel _contactModel = UserContactModel(contact: _contact);
    userDbProvider.updateUserContact(_contactModel, 3);
    fetchUsercontact(3);
  }


  dispose(){
    _usernameController.close();
    _usercontactController.close();
    _userInputController.close();
    _contactInputController.close();
  }
}

final accountBloc = AccountBloc();