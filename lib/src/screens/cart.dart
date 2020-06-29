import 'package:flutter/material.dart';
import '../widgets/cart_button.dart';
import '../blocs/cart_bloc.dart';
import '../models/products.dart';
import '../blocs/checkout_bloc.dart';

class Cart extends StatelessWidget {

  Widget build(BuildContext context) {
    List<ProductsModel> _products = [];
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          CartButton()
        ],
        title: Text('YOUR CART',
        style: TextStyle(
            color: Colors.black,
            fontFamily: 'Montserrat',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF0A0E21),
        child: Icon(Icons.forward),
        onPressed: (){
          checkoutBloc.getCart(_products);
          Navigator.pushNamed(context, '/checkout');
        }
      ),
      body: Card(
        elevation: 5.0,
        color: Colors.white,
        margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        child: StreamBuilder(
          stream: cartBloc.productsCart,
          builder: (context, AsyncSnapshot<List<ProductsModel>> snapshot) {
            if(!snapshot.hasData){
              return Center(
                child: Text('No items in your cart'),
              );
            }
            _products = snapshot.data;
            return ListView.builder(
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              itemCount: _products.length,
              itemBuilder: (context, int index){
                ProductsModel _product = snapshot.data[index];
                return _buildProductsTile(context, _product); 
              }
            );
          }
        ),
      ),
    );
  }

  Widget _buildProductsTile(BuildContext context, ProductsModel _product) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Container(
            width: 100.0,
            height: 200.0,
            padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
            child: Image.network('${_product.imageURL}', fit: BoxFit.fill,),
          ),
          title: Text('${_product.name}'),
          subtitle: Text('${_product.itemCount} ${_product.name} in your cart'),
          trailing: IconButton(
            color: Colors.red,
            iconSize: 20.0,
            icon: Icon(Icons.remove_shopping_cart), 
              onPressed: (){
                cartBloc.removeProduct(_product);  
              }
          ),
        ),
        Divider(thickness: 1.0),
      ],
    );
  }
}