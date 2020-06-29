import 'package:rxdart/rxdart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import '../models/home.dart';
import '../providers/home.dart';

class HomeBloc extends Object {

  HomeProvider _homeProvider = HomeProvider(); 
  final _homeController = BehaviorSubject<List<HomeModel>>(); 
  Stream<List<HomeModel>> get outStream => _homeController.stream;
  Sink<List<HomeModel>> get _inStream => _homeController.sink;
  
  static List<String> _titleList = [
    'Face2pay',
    'Delivery',
    'Warranty',
    'Laptops',
    'Phones',
    'Appliance',
  ];

  static List<String> _imageList = [
  'https://firebasestorage.googleapis.com/v0/b/my-app-118ee.appspot.com/o/face_reg.jpg?alt=media&token=e3b0d8be-8933-46c5-ab4b-c3608dd81a02',
  'https://firebasestorage.googleapis.com/v0/b/my-app-118ee.appspot.com/o/car.png?alt=media&token=0623480a-0c7e-41a5-8e32-758cc4381d07',
  'https://firebasestorage.googleapis.com/v0/b/my-app-118ee.appspot.com/o/warranty-hd-png-today-s-deal-340.png?alt=media&token=93fe54c1-2d14-49a5-a05d-4e7cf35eddae',
  'https://firebasestorage.googleapis.com/v0/b/my-app-118ee.appspot.com/o/download.jpg?alt=media&token=bec9cd33-30e7-418f-afc5-2f05db950f43',
  'https://firebasestorage.googleapis.com/v0/b/my-app-118ee.appspot.com/o/smartphone-xiaomi-phones-transparent-png-10.png?alt=media&token=31be7e8d-89e0-46af-a9d9-ef5abd46d8fe',
  'https://firebasestorage.googleapis.com/v0/b/my-app-118ee.appspot.com/o/appliance.JPG?alt=media&token=68223459-2fc3-4bc5-b8ac-1c4082bbd5ca',
];

  HomeBloc(){
    _inStream.add(_homeProvider.buildGridTile(_imageList, _titleList));
  }

  final _appViewController = BehaviorSubject<String>(); 
  Stream<String> get appViewStream => _appViewController.stream;
  Function(String) get appViewInStream => _appViewController.sink.add;
  
  final _userController = BehaviorSubject<Future<String>>(); 
  Stream<Future<String>> get userStream => _userController.stream;
  
  String getReview() {
    final appReview = _appViewController.value;
    return appReview;
  }

  Future<String> getUser() async {
    FirebaseUser user;
    try{
      final _auth = FirebaseAuth.instance;
      user =  await _auth.currentUser();
    }
    catch(e){
      print(e);
    }
    return user.email;
  }

  dispose() {
    _homeController.close();
    _appViewController.close();
    _userController.close();
  }
}

HomeBloc homeBloc = HomeBloc();