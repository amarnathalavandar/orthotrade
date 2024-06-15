import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:orthotrade/common/widgets/loaders/loaders.dart';
import 'package:orthotrade/data/repositories/products/product_repository.dart';
import 'package:orthotrade/navigation_menu.dart';
import 'package:orthotrade/utils/constants/image_strings.dart';
import 'package:orthotrade/utils/constants/text_strings.dart';
import 'package:orthotrade/utils/helpers/helper_functions.dart';
import 'package:orthotrade/utils/popups/full_screen_loader.dart';

import '../../models/order_items_model.dart';
import '../../models/products_model.dart';

class OrderReviewController extends GetxController {
  static OrderReviewController get instance => Get.find();
  final controller = Get.put(ProductRepository());
  RxList<OrderItemsModel> orderItems = <OrderItemsModel>[].obs;
  RxString postDiscountInvoiceValue = ''.obs;

  double preDiscountInvoiceValue = 0.0;
  RxInt totalNoOfItems = 0.obs;
  RxString a = ''.obs;
  final localStorage = GetStorage();

  /// Will be used in future development

/*  void addToOrders(int quantity, String productId,
      String productTradeName, String productDesc,String productCode,int rate,int amount,double totalAmount) {
    orderItems.add(OrderItemsModel(productCode: productCode,
        productDesc: productDesc,
        rate: rate,
        productId: productId,
        productTradeName: productTradeName,
        quantity: quantity, amount: amount, totalAmount: totalAmount));
}*/

  /// Convert from Product Model to Cart item Model
  OrderItemsModel convertToCartItem(ProductsModel product) {
    return OrderItemsModel(
      productCode: product.productCode,
      productDesc: product.productDesc2,
      productId: product.id,
      productTradeName: product.productTradeName,
      productRef: product.productRef,
      quantity: product.quantity,
      rate: product.rate,
      amount: product.rate,
      discountedPrice: 0.0,
      totalAmount: '',
    );
  }



  /// Calculate Total invoice value & Total No Of Items
  Future<void> updateInvoiceTotal() async {
    final int discountPercent = localStorage.read('DISCOUNTED PERCENT');

    double calculatedTotalPrice = 0.0;
    int calculatedNoOfItems = 0;

    for (OrderItemsModel orderItem in orderItems) {


      orderItem.discountedPrice=await controller.getDiscountValue(orderItem.productId,orderItem.rate);
    print('orderItem.discountedPrice-->${orderItem.discountedPrice}');
    }



    for (var item in orderItems) {
      calculatedTotalPrice += (item.rate) * item.quantity.toDouble();
      calculatedNoOfItems += item.quantity;


    }
    preDiscountInvoiceValue = calculatedTotalPrice;
    postDiscountInvoiceValue.value =
        MOHelperFunctions.getDiscountedInvoiceAmount(
            calculatedTotalPrice, discountPercent);
    totalNoOfItems.value = calculatedNoOfItems;
  }

  /// To Add one item to Order Quantity
  void addOneToCart(ProductsModel item) {
    int index =
        orderItems.indexWhere((product) => product.productId == item.id);
    int quantity = 0;
    if (index >= 0) {
      orderItems[index].quantity += 1;
      orderItems[index].amount =
          orderItems[index].rate * orderItems[index].quantity;
    } else {
      item.quantity = 1;
      orderItems.add(convertToCartItem(item));

    }
    orderItems.refresh();
  }

  /// To Remove one item from Order Quantity
  void removeOneFromCart(ProductsModel item) {
    int index =
        orderItems.indexWhere((product) => product.productId == item.id);
    if (index >= 0) {
      if (orderItems[index].quantity > 1) {
        orderItems[index].quantity -= 1;
      } else {
        // Show dialog  is pending to develop before completely removing
        orderItems.removeAt(index);
      }
    }
    orderItems.refresh();
  }

  /// To update manual entry of order quantity
  void updateQuantity(ProductsModel item, int quantity) {
      int index =
          orderItems.indexWhere((product) => product.productId == item.id);
      if (index >= 0) {
        orderItems[index].quantity = quantity;
        orderItems[index].amount =
            orderItems[index].rate * orderItems[index].quantity;
      } else {
        item.quantity = quantity;
        orderItems.add(convertToCartItem(item));
      }
    orderItems.refresh();
  }

  /// Upload ordered items into firebase after user review
  void uploadOrderItems() {
    try {
      MOFullScreenLoader.openLoadingDialog(
          'We are submitting your Order, Please wait..',
          MOImages.docerAnimation);
      // Upload Order in Firestore DB
      print('orderItems---->>>${orderItems.length}');
      controller.uploadOrder(orderItems, postDiscountInvoiceValue.value);
      // showing success snack bar upon order submission
      MOLoaders.successSnackBar(
          title: MOTexts.greetings, message: MOTexts.orderSuccessful);
    } catch (e) {
      MOLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      MOFullScreenLoader.stopLoading();
      Get.to(() => const NavigationMenu());
      orderItems.clear();
    }
  }


  /// Validate if any items are added to cart
  bool  validateOrder() {
    if (orderItems.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
