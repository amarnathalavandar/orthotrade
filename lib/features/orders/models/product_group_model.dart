import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orthotrade/features/orders/models/products_model.dart';


class ProductGroupModel {
  /// Keep those values final which yo don't want to update

  final String id;
  String productGroupDesc;
  String productCategory;
  List<ProductsModel> productList;


  ProductGroupModel({
    required this.id,
    required this.productGroupDesc,
    required this.productCategory,
    required this.productList,

  });


  /// Static function to create an empty user model

  static ProductGroupModel empty() => ProductGroupModel(
      id: '',
      productGroupDesc: '',
      productCategory: '',
    productList: List.empty(),
);

  /// Convert model to JSON structure for storing data into firebase
  Map<String, dynamic> toJson() {
    return {
      'ProductGroupDesc': productGroupDesc,
      'ProductCategory': productCategory,

    };
  }

  /// Factory method to create a UserModel from a Firebase document snapshot

  factory ProductGroupModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document,List<ProductsModel> productsModelList) {

    if (document.data() != null) {

      final data = document.data()!;

      return ProductGroupModel(
        id: document.id,
        productGroupDesc: data['ProductGroupDesc'] ?? '',
        productCategory: data['ProductCategory'] ?? '',
        productList: [],

      );
    } else {

      return ProductGroupModel.empty();
    }
  }

  factory ProductGroupModel.fromSnapshotwihtoutList(
      DocumentSnapshot<Map<String, dynamic>> document) {

    if (document.data() != null) {

      final data = document.data()!;

      return ProductGroupModel(
        id: document.id,
        productGroupDesc: data['ProductGroupDesc'] ?? '',
        productCategory: data['ProductCategory'] ?? '',
        productList: [],

      );
    } else {

      return ProductGroupModel.empty();
    }
  }
}


