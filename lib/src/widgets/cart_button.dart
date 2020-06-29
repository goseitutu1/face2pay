import 'package:flutter/material.dart';
import '../blocs/cart_bloc.dart';

class CartButton extends StatelessWidget {

  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        IconButton(
          onPressed: (){
            Navigator.pushNamed(context, '/cart');
          },
          icon: Icon(Icons.shopping_cart),
        ),
        Positioned(
          top: 5.0,
          right: 5.0,
          child: CircleAvatar(
            radius: 8.0,
            backgroundColor: Colors.red,
            child: StreamBuilder(
              stream: cartBloc.productsCount,
              initialData: 0,
              builder: (context, AsyncSnapshot<int> snapshot) {
                return Text('${snapshot.data}', style: TextStyle(fontSize: 12.0));
              }
            ),
          ),
        ),
      ]
    );
  }
}