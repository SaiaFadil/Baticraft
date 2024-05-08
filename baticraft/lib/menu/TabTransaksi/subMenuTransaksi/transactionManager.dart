import 'package:baticraft/models/products.dart';
import 'package:flutter/foundation.dart';

class TransactionManager extends ChangeNotifier {
  List<Products> _productList = [];

  List<Products> get productList => _productList;

  void addProduct(Products product) {
    _productList.add(product);
    notifyListeners();
  }
  void clearTransactionData() {
    productList.clear();
  }
 
 

}
