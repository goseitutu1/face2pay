import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/categories.dart';

class ProductsProviders extends Object {

  Stream<QuerySnapshot> getProducts(CategoriesModel category){
    Firestore _firestore = Firestore.instance;
    Stream<QuerySnapshot> _snapshot;
    try{
      _snapshot = _firestore.collection('categories').document(category.id).collection('products').snapshots();
    }
    catch(e){
      print(e);
    }
    return _snapshot;
  }
}