import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'dart:io';

class SignInBloc{
  File image;
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  //Add string to the stream.
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  //Creating stream.
  Stream<String> get emailStream => _emailController.stream.transform(emailValidator);
  Stream<String> get passwordStream => _passwordController.stream.transform(passwordValidator);

  final emailValidator = StreamTransformer<String,String>.fromHandlers(
    handleData: (character,sink){
      if(character.contains('@'))
        sink.add(character);
      else
        sink.addError('enter a valide email address.');
    }
  );

   final passwordValidator = StreamTransformer<String,String>.fromHandlers(
    handleData: (character,sink){
      if(character.length >= 6)
      sink.add(character);
      else
      sink.addError('must be at least 6 characters.');
    }
  );

  String getEmail() {
    final email = _emailController.value;
    return email;
  }

  String getPassword() {
    final password = _emailController.value;
    return password;
  }

  dispose(){
    _emailController.close();
    _passwordController.close();
  }
}

SignInBloc signinBloc = SignInBloc();