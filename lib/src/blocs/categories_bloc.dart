import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:search_app_bar/searcher.dart';
import 'dart:async';
import '../providers/categories.dart';
import '../models/categories.dart';

class CategoriesBloc extends Object implements Searcher<CategoriesModel> {

  final _outCategories = BehaviorSubject<List<CategoriesModel>>();
  final _categoriesProvider = CategoriesProvider();
  List<CategoriesModel> _categoriesList = List();
  
  Stream<List<CategoriesModel>> get outCategories => _outCategories.stream;
  
  CategoriesBloc() {
    _getCategories();
  }

  void _getCategories() {
    _categoriesProvider.getCategories().listen((snapshot){
      List<CategoriesModel> _categories = List();
      for(DocumentSnapshot doc in snapshot.documents){
        CategoriesModel category = CategoriesModel.fromFirestore(doc.data);
        category.id = doc.documentID;
        _categories.add(category);
      }
    _categoriesList.clear();
    _categoriesList.addAll(_categories);
     _outCategories.sink.add(_categoriesList);
    });
  }

  @override
  get onDataFiltered => _outCategories.add;
  
  @override
  get data => _categoriesList;

  dispose(){
    _outCategories.close();
  }
}

CategoriesBloc categoriesBloc = CategoriesBloc();