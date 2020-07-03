import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:search_app_bar/searcher.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import '../models/products.dart';
import '../providers/products.dart';
import '../models/categories.dart';

class ProductsBloc extends Object implements Searcher<ProductsModel>{
  
  final _outProducts = BehaviorSubject<List<ProductsModel>>();
  ProductsModel _product = ProductsModel();
  final _productsProvider = ProductsProviders();
  List<ProductsModel> _productList = List();
   
  Stream<List<ProductsModel>> get outProducts => _outProducts.stream;
  
  void getProducts(CategoriesModel _category) {
    _productsProvider.getProducts(_category).listen((snapshot){
      List<ProductsModel> _products = List();
      for(DocumentSnapshot doc in snapshot.documents){
        _product = ProductsModel.fromFirestore(doc.data);
        _product.id = doc.documentID;
        _products.add(_product);
      }
      _productList.clear();
      _productList.addAll(_products);
      _outProducts.sink.add(_productList);
    });
  }

  @override
  get onDataFiltered => _outProducts.add;

  @override
  get data => _productList;

  dispose(){
    _outProducts.close();
  }
}

ProductsBloc productsBloc = ProductsBloc();