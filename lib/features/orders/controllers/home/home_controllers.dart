import 'package:get/get.dart';
import 'package:orthotrade/data/repositories/products/product_repository.dart';

import '../../models/forms_model.dart';

class HomeController extends GetxController
{
  static HomeController get instance =>Get.find();

  RxList<FormsModel> formsList = <FormsModel>[].obs;
  @override
  void onInit() {

    super.onInit();
    fetchFormDetails();
    //fetchOrdersCount();
  }

  final productRepository = Get.put(ProductRepository());
  RxInt ordersCount=0.obs;
  final carousalCurrentIndex =0.obs;
  void updatePageIndicator(index)
  {
    carousalCurrentIndex.value=index;
  }

/*
 /// Fetch Form Data Record
  Future<void> fetchOrdersCount() async {
    try {
      print('-----------------fetchOrdersCount-START--------------------');
      ordersCount.value = await productRepository.fetchOrdersCount();
      print('-----------------fetchOrdersCount-END---------------------${ordersCount.value }');

    } catch (e) {
      print(e.toString());
    }
  }
*/

  Future<List<FormsModel>> fetchFormDetails() async {
    try {
      formsList.value = await productRepository.fetchFormDetails();
      return formsList;
    } catch (e) {
      print(e.toString());
      return[];
    }

  }



}