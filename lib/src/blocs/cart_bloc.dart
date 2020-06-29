import 'package:rxdart/rxdart.dart';
import 'dart:async';
import '../models/products.dart';
import '../models/cart.dart';

class CartBloc extends Object {
   
  final _products = CartModel.products;

  final _cartController = BehaviorSubject<List<ProductsModel>>(); 
  Stream<List<ProductsModel>> get productsCart => _cartController.stream;
  Sink<List<ProductsModel>> get _inproducts => _cartController.sink;

  final _productsCountController = BehaviorSubject<int>(); 
  Stream<int> get productsCount => _productsCountController.stream;
  Sink<int> get _inproductsCount => _productsCountController.sink;

  void addProduct(ProductsModel _product) {
    if(_products.contains(_product)){
      _products[_products.indexOf(_product)].itemCount++;
    }
    else{
      _product.itemCount = 1;
      _products.add(_product);
    }
    
    CartModel.productCount++;
    _inproductsCount.add(CartModel.productCount);
    _inproducts.add(_products);
  }

  void removeProduct(ProductsModel product){
    if(_products.contains(product)){
      _products[_products.indexOf(product)].itemCount--;
      CartModel.productCount--;
      if(product.itemCount == 0){
        _products.remove(product);
      } 
    }
    
    _inproductsCount.add(CartModel.productCount);
    _inproducts.add(_products);
  }

  dispose() {
    _cartController.close();
    _productsCountController.close();
  }
}

CartBloc cartBloc = CartBloc();