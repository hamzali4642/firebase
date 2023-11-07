import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier{
  int counter = 0;


  void increment(){
    counter ++;
    notifyListeners();
  }

  void decrement(){
    counter --;
    notifyListeners();
  }


}