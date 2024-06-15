
import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class OrderItemsModel {
  String productId;
  String productDesc;
  String productCode;
  String productTradeName;
  String productRef;

  int quantity; // Quantity of product
  int rate; // Rate per product
  int amount; // Amount of each product (quantity * rate)
  double discountedPrice;
  String totalAmount; // total invoice



  OrderItemsModel({
    required this.productCode,
    required this.productDesc,
    required this.productId,
    required this.productTradeName,
    required this.productRef,
    required this.quantity,
    required this.rate,
    required this.amount,
    required this.totalAmount,
    this.discountedPrice=0.0,

  });

  /// Convert model to JSON structure for storing data into firebase, will be used in future development

  Map<String, dynamic> toJson() {

    return {
      'ProductId': productId,
      'Quantity': quantity,
    };
  }

}
