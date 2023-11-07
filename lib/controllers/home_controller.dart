import 'package:get/get.dart';

import '../model/user_model.dart';

class HomeController extends GetxController{
  RxInt counter = 0.obs;

  void increment(){
    counter ++;
  }


  RxInt counter2 = 0.obs;

  void increment2(){
    counter2 ++;
  }

}