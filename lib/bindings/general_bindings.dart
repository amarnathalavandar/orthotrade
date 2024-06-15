import 'package:get/get.dart';
import '../features/orders/controllers/home/home_controllers.dart';
import '../utils/networkconnection/network_manager.dart';


class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    /// -- Core
    Get.put(NetworkManager());
    Get.put(HomeController());


    /// -- Product
   // Get.put(ProductsController());

  }
}
