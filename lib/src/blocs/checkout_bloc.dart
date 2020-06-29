import 'package:rxdart/rxdart.dart';
import 'dart:async';
import '../models/products.dart';
import '../models/transaction.dart';

class CheckoutBloc{
  final _emailController = BehaviorSubject<String>();
  final _telephoneController = BehaviorSubject<String>();
  final _nameController = BehaviorSubject<String>();
  final _totalAmountController = BehaviorSubject<double>();
  final _productsCountController = BehaviorSubject<int>();
  
  
  
  //Add string to the stream.
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changeTelephone => _telephoneController.sink.add;
  Function(String) get changename => _nameController.sink.add;
  Function(double) get _inTotalAmount => _totalAmountController.sink.add;
  Function(int) get _inProductsCount => _productsCountController.sink.add;
 
 
 

  //Creating stream.
  Stream<String> get emailStream => _emailController.stream.transform(emailValidator);
  Stream<String> get telephoneStream => _telephoneController.stream.transform(telephoneValidator);
  Stream<String> get nameStream => _nameController.stream;
  Stream<double> get totalAmountStream => _totalAmountController.stream;
  Stream<int> get productsCountStream => _productsCountController.stream;
  
  
  

  final emailValidator = StreamTransformer<String,String>.fromHandlers(
    handleData: (character,sink){
      if(character.contains('@'))
        sink.add(character);
      else
        sink.addError('enter a valide email address.');
    }
  );

  final telephoneValidator = StreamTransformer<String,String>.fromHandlers(
    handleData: (character,sink){
      if(character.length == 10)
      sink.add(character);
      else
      sink.addError('must be 10 digits.');
    }
  );

  String getEmail() {
    final email = _emailController.value;
    return email;
  }

  String getTelephone() {
    final telephone = _telephoneController.value;
    return telephone;
  }

  String getName() {
    final name = _nameController.value;
    return name;
  }
 
  void getCart(List<ProductsModel> _products) {
    List<TransactionModel> _translist = [];
    double _totalAmount = 0.0;
    int _productsCount = 0;
    for(var _product in _products){
      _totalAmount = _totalAmount + (_product.price * _product.itemCount);
      _productsCount = _productsCount + _product.itemCount;
    }

    _inTotalAmount(double.parse((_totalAmount).toStringAsFixed(2)));
    _inProductsCount(_productsCount);
    _translist.add(TransactionModel(productCount: _productsCount, totalAmount: _totalAmount));
    _intransList.add(_translist);
  }

  final _transController = BehaviorSubject<List<TransactionModel>>(); 
  Stream<List<TransactionModel>> get transList => _transController.stream;
  Sink<List<TransactionModel>> get _intransList => _transController.sink;

  final _notificationController = BehaviorSubject<int>(); 
  int _notification = 0;
  Stream<int> get notificationCount => _notificationController.stream;
  Sink<int> get _inputNotification => _notificationController.sink;

  void getNotification() {
   _notification++;
   _inputNotification.add(_notification);
  }

 
  dispose(){
    _emailController.close();
    _telephoneController.close();
    _nameController.close();
    _totalAmountController.close();
    _productsCountController.close();
    _transController.close();
    _notificationController.close();
  }
}

CheckoutBloc checkoutBloc = CheckoutBloc();