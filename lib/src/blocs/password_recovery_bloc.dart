import 'package:rxdart/rxdart.dart';
import 'dart:async';

class PasswordRecoveryBloc{
  final _emailController = BehaviorSubject<String>();

  //Add string to the stream.
  Function(String) get changeEmail => _emailController.sink.add;
  
  //Creating stream.
  Stream<String> get emailStream => _emailController.stream.transform(emailValidator);
 
  final emailValidator = StreamTransformer<String,String>.fromHandlers(
    handleData: (character,sink){
      if(character.contains('@'))
        sink.add(character);
      else
        sink.addError('enter a valide email address.');
    }
  );

  String getEmail() {
    final email = _emailController.value;
    return email;
  }

  dispose(){
    _emailController.close();
  }
}

PasswordRecoveryBloc passwordRecoveryBloc = PasswordRecoveryBloc();