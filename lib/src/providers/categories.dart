import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriesProvider extends Object {

  Stream<QuerySnapshot> getCategories() {
    Firestore _firestore = Firestore.instance;
    Stream<QuerySnapshot> _snapshot;
    try{
      _snapshot = _firestore.collection('categories').snapshots();
    }
    catch(e){
      print(e);
    }
    return _snapshot;
  }
}