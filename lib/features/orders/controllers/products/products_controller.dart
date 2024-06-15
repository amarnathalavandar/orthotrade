import 'package:get/get.dart';

import '../../../../common/widgets/loaders/loaders.dart';
import '../../../../data/repositories/products/product_repository.dart';
import '../../models/product_group_model.dart';
import '../../models/products_model.dart';


class ProductsController extends GetxController
{
  static ProductsController get instance => Get.find();

  /// Variables
  RxList<ProductGroupModel> allproductgroups = <ProductGroupModel>[].obs;
  List<ProductsModel> orderedProducts = [];
  RxList<ProductsModel> orderedProductsNew = <ProductsModel>[].obs;

final isLoading =false.obs;
final productRepository = Get.put(ProductRepository());



  @override
  void onInit() {
    super.onInit();
    fetchGroupAndProducts();
  }

/*/// Will be used for future as a reference.
Future<List<ProductsModel>> getFilteredProducts() async{
    try
    {
       print('-------getFilteredProducts-------------------------------getFilteredProducts-------');
       orderedProducts = allproductgroups
        .expand((group) => group.productList)
        .where((product) => product.quantity != null && product.quantity! > 0)
        .toList();
       orderedProducts.forEach((product) {
        print("Name: ${product.productDesc2}, Quantity: ${product.quantity ?? 'N/A'}");
      });
      isLoading.value=true;
      return orderedProducts;
    }
    catch(e){
      MOLoaders.errorSnackBar(title: 'Error Occurred while loading ordered products,Contact Administrator', message: e.toString());
      return[];
    }
  }


  void updateOrderedProducts(int index,int subIndex,String productId)
  {
    print('----------------productId-------------------------$productId');
    bool isProductAvailable =orderedProductsNew.any((product) => product.id == productId);
    if (!isProductAvailable)
    {
      orderedProductsNew.add(allproductgroups.value[index].productList[subIndex]);
   }
    }*/

    /// To Retrieve products groups and products from firebase

   Future<List<ProductGroupModel>> fetchGroupAndProducts() async{
   try
    {
      List<ProductGroupModel> productGroups = [];
      final productgroups = await productRepository.fetchGroupAndProducts();
      isLoading.value=true;
      allproductgroups.assignAll(productgroups);
      final prdLength=allproductgroups.length;
      print('Product ID Length:$prdLength');
      return productgroups;
    }
    catch(e){
      MOLoaders.errorSnackBar(title: 'Error Occurred while fetching Products List,Contact Administrator', message: e.toString());
      return[];
    }
  }



  }

