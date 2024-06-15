import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


class OrdersListModel {
  /// Keep those values final which yo don't want to update

  final String orderId;

  String invoiceValue ;
  String orderDate;
  String invoiceNo;

  OrdersListModel({
    required this.orderId,
    required this.invoiceValue,
    required this.orderDate,
    required this.invoiceNo,

  });


  /// Static function to create an empty user model

  static OrdersListModel empty() => OrdersListModel(
    orderId: '',
    invoiceValue: '',
    orderDate:'',
    invoiceNo:''
  );


  /// Factory method to create a UserModel from a Firebase document snapshot

  factory OrdersListModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {

    if (document.data() != null) {

      final data = document.data()!;
      Timestamp? orderTimestamp = data['OrderDate'] as Timestamp?;

      String orderDate = orderTimestamp != null
          ? DateFormat.yMMMEd().format(orderTimestamp.toDate())
          : '';
      return OrdersListModel(
        orderId: document.id,
        invoiceValue: data['InvoiceValue'] ?? '',
        orderDate: orderDate,
        invoiceNo: data['InvoiceNo'] ?? '',
      );
    } else {

      return OrdersListModel.empty();
    }
  }

}


