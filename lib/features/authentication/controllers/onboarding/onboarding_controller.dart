import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../screens/login/login.dart';


class OnBoardingController extends GetxController{

    static OnBoardingController get instance =>Get.find();

  final pageController = PageController();
  RxInt currentPageIndex = 0.obs;
  // Update Current Index when Page Scroll
  void updatePageIndicator(index) => currentPageIndex.value=index;

  // Jump to specific dot selected page
  void dotNavigationClick(index){
currentPageIndex.value=index;
pageController.jumpToPage(currentPageIndex.value);
  }
  // Update Current Index and jump to last page
  void nextPage()
  {
if(currentPageIndex.value==2)
  {
    final deviceStorage= GetStorage();

    deviceStorage.write('isFirstTime',false);
    Get.to(const LoginScreen());
  }
else
  {
    int page=currentPageIndex.value+1;
    pageController.jumpToPage(page);
  }
if(kDebugMode){
  print('DEBUG MODE =====================>');
  print(GetStorage().read('isFirstTime'));
}

  }
  // Update current index and jump to last page
  void skipPage()
  {
    currentPageIndex.value=2;
    pageController.jumpToPage(2);
  }
}