import 'package:flutter/material.dart';
import 'package:my_app/src/widgets/cart_button.dart';
import 'package:search_app_bar/filter.dart';
import 'package:search_app_bar/search_app_bar.dart';
import '../blocs/products_bloc.dart';
import '../widgets/cart_button.dart';
import '../models/products.dart';
import '../blocs/cart_bloc.dart';

class Products extends StatelessWidget {
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBar<ProductsModel>(
        searcher: productsBloc,
        filter: (ProductsModel product, String query) => Filters.startsWith(product.name, query),
        flattenOnSearch: true,
        searchBackgroundColor: Colors.white,
        hintText: 'Search on products',
        searchButtonPosition: 0,
        actions: <Widget>[
          CartButton(),
        ],
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('our products',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF0A0E21),
        child: Icon(Icons.forward),
        onPressed: (){
          Navigator.pushNamed(context, '/cart');
        }
      ),
      body: Card(
        elevation: 5.0,
        margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        color: Colors.white,
        child: StreamBuilder(
          stream: productsBloc.outProducts,
          builder: (context, AsyncSnapshot<List<ProductsModel>> snapshot){
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            else{
              return ListView.builder(
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                itemCount: snapshot.data.length,
                itemBuilder: (context, int index) {
                  ProductsModel _product = snapshot.data[index];
                  return _buildTile(context, _product);
                },
              );
            }
          }
        ),
      ),
    );
  }

  Widget _buildTile(BuildContext context, ProductsModel _product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 200.0,
          height: 200.0,
          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(width: 1.0, color: Colors.grey)
          ),
          child: Image.network('${_product.imageURL}', fit: BoxFit.fill,),
        ),
        ListTile(
          leading: Text(
            '${_product.price} \$', 
            style: TextStyle(
              color: Colors.red, 
              fontWeight: FontWeight.bold
            ),
          ),
          title: Text(
            '${_product.name}', 
            style: TextStyle( 
              fontFamily: 'Montserrat',
              fontSize: 15.0, 
              fontWeight: FontWeight.bold,
            )
          ),
          subtitle: Text('${_product.description}'),
          trailing: IconButton(
            color: Colors.red,
            iconSize: 30.0,
            icon: Icon(Icons.add_shopping_cart), 
            onPressed: (){
              cartBloc.addProduct(_product);
            }
          ),
        ),
        Divider(thickness: 1.0),         
      ],
    );
  }

}