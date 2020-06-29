import 'package:flutter/material.dart';
import 'package:search_app_bar/filter.dart';
import 'package:search_app_bar/search_app_bar.dart';
import '../blocs/categories_bloc.dart';
import '../models/categories.dart';
import '../widgets/cart_button.dart';
import '../blocs/products_bloc.dart';

class Categories extends StatelessWidget {
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBar<CategoriesModel>(
        searcher: categoriesBloc,
        filter: (CategoriesModel category, String query) => Filters.startsWith(category.name, query),
        flattenOnSearch: true,
        searchBackgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        hintText: 'Search on categories',
        searchButtonPosition: 0,
        actions: <Widget>[
          CartButton(),
        ],
        title: Text('select a category ',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Card(
        color: Colors.white,
        elevation: 5.0,
        margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        child: StreamBuilder(
          stream: categoriesBloc.outCategories,
          builder: (BuildContext context, AsyncSnapshot<List<CategoriesModel>> categories) {
            if(!categories.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              itemCount: categories.data.length,
              itemBuilder: (BuildContext context, int index){
                CategoriesModel category = categories.data[index];
                return _categoriesTile(context, category);
              },
            );
          }
        ),
      ),
    );
  }

  Widget _categoriesTile(BuildContext context, CategoriesModel category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Color(0xffF3F1F4),
          ),
          child: ListTile(
            onTap: (){
              productsBloc.getProducts(category);
              Navigator.pushNamed(context, '/products');
              },
            title: Text(
              '${category.name}',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Text(
              'SEE ALL',
              style: TextStyle(
                color: Colors.red,
                fontFamily: 'Montserrat',
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            )
          ),
        ),
        SizedBox(height:5.0),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 190.0,
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Color(0xffF3F1F4),
            border: Border.all(width: 1.0, color: Colors.grey)
          ),
          child: GridView.count(
            mainAxisSpacing: 20.0,
            childAspectRatio: 0.9,
            crossAxisSpacing: 20.0,
            crossAxisCount: 2,
              children: <Widget>[
                GridTile(
                  child: Image.network('${category.imageURL2}'),
                  footer: Text('${category.childName2}',textAlign: TextAlign.center,),
                ),
                GridTile(
                  child: Image.network('${category.imageURL1}'),
                  footer: Text('${category.childName1}',textAlign: TextAlign.center,),
                ),
              ]
            ),
          ),
        SizedBox(height: 20.0), 
      ],
    );
  }

}