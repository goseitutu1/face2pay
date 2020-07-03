import 'package:flutter/material.dart';
import '../blocs/checkout_bloc.dart';
import '../models/transaction.dart';

class Transaction extends StatelessWidget {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction history',
        style: TextStyle(
            color: Colors.black,
            fontFamily: 'Montserrat',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
      ),
      body:  Card(
        margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        elevation: 5.0,
        color: Colors.white,
        child:  StreamBuilder(
          stream: checkoutBloc.transList,
          builder: (context, AsyncSnapshot<List<TransactionModel>> snapshot) {
            if(!snapshot.hasData){
              return Center(child: Text('No transaction'),);
            }
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, int index) {
                if(!snapshot.hasData){
                  return Center(child: Text('No transaction'),);
                }
                return Column(
                  children: <Widget>[
                 ListTile(
                  leading: Text('${index+1}'),
                  title: Text(
                    'Items Purchased : ${snapshot.data[index].productCount}',
                    style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Montserrat',
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                 ),
                 trailing: Text(
                    '\$ ${snapshot.data[index].totalAmount}',
                    style: TextStyle(
                    color: Colors.red,
                    fontFamily: 'Montserrat',
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                 ),
               ),
               Divider(thickness: 1.0,),
               ]
                );
              }
            );
          }
        ),
      ), 
    );
  }
  
}