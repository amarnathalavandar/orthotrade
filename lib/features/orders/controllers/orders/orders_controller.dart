import 'package:get/get.dart';
import 'package:orthotrade/common/widgets/loaders/loaders.dart';

import '../../../../data/repositories/products/product_repository.dart';
import '../../models/orders_list_model.dart';


class OrdersController extends GetxController
{

  static OrdersController get instance => Get.find();


  final isLoading = false.obs;
  final productRepository = Get.put(ProductRepository());
  RxList<OrdersListModel> ordersList = <OrdersListModel>[].obs;


  @override
  void onInit() {
    super.onInit();
    fetchOrdersList();

  }

  /// Fetch Products using Stream so, any change can immediately take effect.
  void fetchOrdersList() async {
    try {
      // Show loader while loading Orders
      isLoading.value = true;
      print('calledfetchOrdersList ');
      // Fetch Orders
      final orders = await productRepository.fetchOrders();

      // Assign Orders
      ordersList.assignAll(orders);

    } catch (e) {
      MOLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      print(e.toString());
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }
}

