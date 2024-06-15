import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsModel {
  ProductsModel(
      {
      required this.id,
      required this.groupId,
      required this.productCode,
      required this.productDesc2,
      required this.productTradeName,
      required this.quantity,
      required this.productRef,
      this.rate = 10
      });

  /// Keep those values final which yo don't want to update
  final String id;
  String groupId;
  String productCode;

  int rate;

  /// Product Description
  String productDesc2;
  String productTradeName;
  String productRef;
  int quantity;

  ///Product Specifications for Future


  /// Generate Complete Product Name
  static String generateCompleteProductName(productRef, productDesc2) {
    String upperProductRef = productRef.toUpperCase();
    String upperProductDesc2 = productDesc2.toUpperCase();

    return '$upperProductDesc2 [$upperProductRef]';
  }



  /// Static function to create an empty Products Model

  static ProductsModel empty() => ProductsModel(
        id: '',
        productCode: '',
        productDesc2: '',
        productTradeName: '',
        productRef:'',
        groupId: '',
        quantity: 0,
      );


  /// Factory method to create a UserModel from a Firebase document snapshot

  factory ProductsModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      return ProductsModel(
        id: document.id,
        groupId: data['GroupId'],
        productCode: data['ProductCode'] ?? '',
        productDesc2: data['ProductDesc2'] ?? '',
        productTradeName: data['ProductTradeName'] ?? '',
        productRef: data['ProductRef'] ?? '',
        quantity: 0,

      );
    } else {
      return ProductsModel.empty();
    }
  }
}
