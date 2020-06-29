import 'package:flutter/material.dart';
import 'package:my_app/src/widgets/material_button.dart';
import '../widgets/text_feild.dart';
import '../blocs/checkout_bloc.dart';

class CheckOut extends StatelessWidget {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xffF3F1F4),
      appBar: AppBar(
        title: Text('CHECKOUT',
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
        margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        elevation: 5.0,
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          children: <Widget>[
            _informationTile(context),
            SizedBox(height: 20.0),
            _payTile(context),
          ],
        ), 
      ),
    );
  }

  Widget _informationTile(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.info_outline, color: Colors.red, size: 20.0,),
                SizedBox(width: 5.0),
                Text(
                  'Information',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                )
              ]
            ),
            SizedBox(height: 20.0),
            StreamBuilder(
              stream: checkoutBloc.emailStream,
              builder: (context, AsyncSnapshot<String> snapshot){
                return TextFeild(
                  obscureText: false, 
                  icon: Icon(Icons.email), 
                  hintText: 'Email', 
                  onChanged: checkoutBloc.changeEmail, 
                  errorText: snapshot.error,
                );
              }
            ),
            SizedBox(height: 20.0),
            StreamBuilder(
              stream: checkoutBloc.telephoneStream,
              builder: (context, AsyncSnapshot<String> snapshot){
                return TextFeild(
                  errorText: snapshot.error, 
                  icon: Icon(Icons.phone), 
                  hintText: 'Telephone', 
                  onChanged: checkoutBloc.changeTelephone, 
                  obscureText: false,
                );
              }
            ),
            SizedBox(height: 20.0),
            StreamBuilder(
              stream: checkoutBloc.nameStream,
              builder: (context, AsyncSnapshot<String> snapshot){
                return TextFeild(
                  errorText: snapshot.error, 
                  icon: Icon(Icons.person), 
                  hintText: 'Name', 
                  onChanged: checkoutBloc.changename, 
                  obscureText: false,
                );
              }
            ),   
          ]
        ),
    );
  }

  Widget _payTile(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.attach_money, color: Colors.red, size: 20.0,),
                SizedBox(width: 5.0),
                Text(
                  'Pay',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                )
              ]
            ),
            SizedBox(height: 20.0,),
            StreamBuilder(
              stream: checkoutBloc.productsCountStream,
              builder: (context, AsyncSnapshot<int> _productsCount) {
                return ListTile(
                  title: Text('Number of products in your cart'),
                  trailing: Text(
                    '${_productsCount.data}',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                );
              }
            ),
            Divider(thickness: 1.0,),
            StreamBuilder(
              stream: checkoutBloc.totalAmountStream,
              builder: (context, AsyncSnapshot<double> _totalAmount) {
                return ListTile(
                  title: Text('Total amount'),
                  trailing: Text(
                    '\$ ${_totalAmount.data}',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
               );
              }
            ),
            Divider(thickness: 1.0,),
            ListTile(
              title: Text('Facial recognition is required for user verification and authentication.'),
            ),
            Divider(thickness: 1.0,),
            Button(
              onPressed: (){
                print('${checkoutBloc.getEmail()}');
                print('${checkoutBloc.getTelephone()}');
                print('${checkoutBloc.getName()}');
                checkoutBloc.getNotification();
                 _scaffoldKey.currentState.showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(
                      'Transaction Completed',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
                // _payAletDialog(context);
              }, 
              description: 'verify user',
            ),
          ]
        ),
      );
  }
 
  // Future<Widget> _payAletDialog(BuildContext context){
  //   return showDialog(
  //     context: context,
  //     builder: (context) {
  //           return AlertDialog(
  //             title: Text('Select one option'), 
  //             actions: <Widget>[
  //               Button(
  //                 description: 'Use app wallet',
  //                 onPressed: (){
  //                   Navigator.of(context).pop();
  //                    checkoutBloc.getNotification();
  //                   _scaffoldKey.currentState.showSnackBar(
  //                   SnackBar(
  //                   backgroundColor: Colors.red,
  //                   content: Text(
  //                     'Transaction failed : money no enough',
  //                     style: TextStyle(
  //                       color: Colors.black,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                 ),
  //               );
  //                 },
  //               ),
  //               SizedBox(height: 10.0),
  //               Button(
  //                 description: 'Pay on delivery',
  //                 onPressed: (){
  //                   Navigator.of(context).pop();
  //                    checkoutBloc.getNotification();
  //               _scaffoldKey.currentState.showSnackBar(
  //                 SnackBar(
  //                   backgroundColor: Colors.red,
  //                   content: Text(
  //                     'Transaction Completed',
  //                     style: TextStyle(
  //                       color: Colors.black,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                 ),
  //               );
  //                   },
  //               ),
  //             ],
  //           );
  //         }
  //       );
  //     }
  }

