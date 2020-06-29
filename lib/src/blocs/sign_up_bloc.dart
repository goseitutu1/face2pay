import 'package:rxdart/rxdart.dart';
import 'dart:async';

class SignUpBloc{
  final _emailController = BehaviorSubject<String>();
  static BehaviorSubject _passwordController = BehaviorSubject<String>();
  final _usernameController = BehaviorSubject<String>();
  final _confirmPasswordController = BehaviorSubject<String>();

  //Add string to the stream.
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeUsername => _usernameController.sink.add;
  Function(String) get changeConfirmPassword => _confirmPasswordController.sink.add;

  //Creating stream.
  Stream<String> get emailStream => _emailController.stream.transform(emailValidator);
  Stream<String> get passwordStream => _passwordController.stream.transform(passwordValidator);
  Stream<String> get confirmPasswordStream => _confirmPasswordController.stream.transform(confirmPasswordValidator);
  Stream<String> get usernameStream => _usernameController.stream.transform(usernameValidator);
  
   final usernameValidator = StreamTransformer<String,String>.fromHandlers(
    handleData: (character,sink){
      if(character.length >= 7)
      sink.add(character);
      else
      sink.addError('must be at least 7 characters.');
    }
  );

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
  
  static String _password = _passwordController.value;
  final confirmPasswordValidator = StreamTransformer<String,String>.fromHandlers(
    handleData: (character,sink){
      if(character == _password)
      sink.add(character);
      else
      sink.addError('password is not equal.');
    }
  );

  String getEmail() {
    final email = _emailController.value;
    return email;
  }

  String getPassword() {
    return _password;
  }

  String getConfirmPassword() {
    final confirmPassword = _confirmPasswordController.value;
    return confirmPassword;
  }

  dispose(){
    _emailController.close();
    _passwordController.close();
    _confirmPasswordController.close();
    _usernameController.close();
  }
}

SignUpBloc signUpBloc = SignUpBloc();