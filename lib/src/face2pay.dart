import 'package:flutter/material.dart';
import 'screens/welcome.dart';
import 'screens/sign_in.dart';
import 'screens/sign_up.dart';
import 'widgets/bottom_nav.dart';
import 'screens/account.dart';
import 'screens/categories.dart';
import 'screens/products.dart';
import 'screens/cart.dart';
import 'screens/check_out.dart';
import 'screens/password_recovery.dart';
import 'screens/reg_face.dart';
import 'screens/transaction.dart';
import 'screens/face_signIn.dart';

class Face2Pay extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Face2pay',
       theme: ThemeData(
        primaryColor: Color(0xffF3F1F4),
       ),
      onGenerateRoute: routes,
    );
  } 
}


Route routes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
      return MaterialPageRoute(
        builder: (context) {
          return Welcome();
        }
        );
      break;

      case '/signin':
      return MaterialPageRoute(
        builder: (context) {
          return SignIn();
        }
        );
      break;

      case '/signup':
      return MaterialPageRoute(
        builder: (context) {
          return SignUp();
        }
        );
      break;

      case '/home':
      return MaterialPageRoute(
        builder: (context) {
          return BottomNavigator();
        }
      );
      break;

      case '/account':
      return MaterialPageRoute(
        builder: (context) {
          return Account();
        }
      );
      break;

      case '/transaction':
      return MaterialPageRoute(
        builder: (context) {
          return Transaction();
        }
      );
      break;

      case '/categories':
      return MaterialPageRoute(
        builder: (context) {
          return Categories();
        }
      );
      break;

      case '/products':
      return MaterialPageRoute(
        builder: (context) {
          return Products();
        }
      );
      break;

      case '/cart':
      return MaterialPageRoute(
        builder: (context) {
          return Cart();
        }
      );
      break;

      case '/checkout':
      return MaterialPageRoute(
        builder: (context) {
          return CheckOut();
        }
      );
      break;

      case '/password_recovery':
      return MaterialPageRoute(
        builder: (context) {
          return PasswordRecovery();
        }
      );
      break;

      case '/registerface':
      return MaterialPageRoute(
        builder: (context) {
          return RegisterFace();
        }
      );
      break;

      case '/facesignin':
      return MaterialPageRoute(
        builder: (context) {
          return FaceSignIn();
        }
      );
      break;

      default:
      return null;
    }
}
