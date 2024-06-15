import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/products/product_repository.dart';
import '../../models/forms_model.dart';

class MOSearchController extends GetxController {
  static MOSearchController get instance => Get.find();

  RxList<FormsModel> searchResults = <FormsModel>[].obs;
  RxBool isLoading = false.obs;
  RxString lastSearchQuery = ''.obs;
  RxDouble minPrice = 0.0.obs;
  RxDouble maxPrice = double.infinity.obs;
  final RxString searchQuery = ''.obs;
  final RxString selectedCategoryId = ''.obs;
  List<String> sortingOptions = ['Name', 'Lowest Price', 'Highest Price', 'Popular', 'Newest', 'Suitable'];
  RxString selectedSortingOption = 'Name'.obs; // Default sorting option

/*  void search() {
    searchProducts(
      searchQuery.value,
      categoryId: selectedCategoryId.value.isNotEmpty ? selectedCategoryId.value : null,
      minPrice: minPrice.value != 0.0 ? minPrice.value : null,
      maxPrice: maxPrice.value != double.infinity ? maxPrice.value : null,
      sortingOption: selectedSortingOption.value,
    );
  }*/


  void searchProducts(String query) async {
    lastSearchQuery.value = query;
    isLoading.value = true;

    try {
      final results = await ProductRepository.instance
          .searchProducts(query);

      searchResults.assignAll(results);
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching data: $e');
      }
    } finally {
      isLoading.value = false;
    }
  }
}
