import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:orthotrade/features/orders/models/forms_model.dart';
import 'package:orthotrade/features/orders/models/order_items_model.dart';
import 'package:orthotrade/features/orders/models/orders_list_model.dart';

import '../../../features/orders/models/product_group_model.dart';
import '../../../features/orders/models/products_model.dart';
import '../../../features/pdf/invoice_pdf_generator.dart';
import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final localStorage = GetStorage();
  List<OrderItemsModel> orderedItems = <OrderItemsModel>[];


  /// Get all Product groups for Stepper - Not used
/*
  Future<List<ProductGroupModel>> fetchProductGroups() async {
    try {
      // Since its cloud query we should use await
      final snapshot = await _db.collection("productgroups").get();
      final list = snapshot.docs
          .map((document) => ProductGroupModel.fromSnapshotwihtoutList(document))
          .toList();
      return list;
    } on FirebaseAuthException catch (e) {
      throw MOFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MOFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MOFormatException();
    } on PlatformException catch (e) {
      throw MOPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
*/

  Future<List<OrdersListModel>> fetchOrders() async {
    try {
      print('fetchOrders');
      final snapshot = await _db.collection("orders").where(
          'UserId', isEqualTo: localStorage.read('USERID')).orderBy(
          'OrderDate', descending: true).get();
      return snapshot.docs.map((querySnapshot) =>
          OrdersListModel.fromSnapshot(querySnapshot)).toList();
    } on FirebaseAuthException catch (e) {
      throw MOFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MOFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MOFormatException();
    } on PlatformException catch (e) {
      throw MOPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get Product description and details
  Future<List<ProductGroupModel>> fetchGroupAndProducts() async {
    try {
      final snapshot = await _db.collection("productgroups").orderBy(
          'ProductCategory').get();

      List<ProductGroupModel> groupsAndProducts = await Future.wait(
          snapshot.docs.map((productGroupDoc) async {
            List<ProductsModel> productsArray = [];
            QuerySnapshot productSnapshot = await _db
                .collection('products')
                .where('GroupId', isEqualTo: productGroupDoc.id)
                .get();
            String groupName = productGroupDoc['ProductGroupDesc'];
            //print('<=========$groupName===================>');

            productsArray = productSnapshot.docs.map((productDoc) {
      /*        print(
                  '----------------------Product details START-----------------------------');
              print('Product ID: ${productDoc.id}');
              print('Product Desc: ${productDoc['ProductDesc2']}');
              print('Product Code: ${productDoc['ProductCode']}');
              print('Product Code: ${productDoc['ProductTradeName']}');
              print(
                  '----------------------Product details END-----------------------------');
*/
              return ProductsModel(
                id: productDoc.id,
                groupId: productDoc['GroupId'],
                productCode: productDoc['ProductCode'],
                productDesc2: productDoc['ProductDesc2'],
                productTradeName: productDoc['ProductTradeName'],
                productRef: productDoc['ProductRef'],
                quantity: 0,
                rate: productDoc['Rate'],
              );
            }).toList();
            return ProductGroupModel(
              id: productGroupDoc.id,
              productGroupDesc: productGroupDoc['ProductGroupDesc'] ?? '',
              productCategory: productGroupDoc['ProductCategory'] ?? '',
              productList: productsArray,
            );
          }

          ));
      return groupsAndProducts;
    } on FirebaseAuthException catch (e) {
      throw MOFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MOFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MOFormatException();
    } on PlatformException catch (e) {
      throw MOPlatformException(e.code).message;
    } catch (e) {
      print('$e');
      throw e.toString();
    }
  }


  Future<double> getDiscountValue(String productId,int actualPrice) async{


    num discountedPrice=0;

    final snapshot = await _db.collection('productuserprice')
        .where('userId', isEqualTo: localStorage.read('USERID'))
        .where('productId', isEqualTo: productId)
        .get();
    // Check if the snapshot contains any documents
    if (snapshot.size > 0) {
      print('MORE THAN 1 ');


      // Extract the first document (assuming there's only one matching document)
      var document = snapshot.docs.first;

      // Retrieve the discountPercent and price from the document
      int userDiscountPercent = document['discountPercent'];

      // Calculate the discountable value
      if(userDiscountPercent>0)
      {

        print('PRODUCT ID 1 --->$productId :PERCENT: $userDiscountPercent');

        discountedPrice = actualPrice * (userDiscountPercent / 100);
      }
      else
      {
        int userDiscountPrice = document['discountPrice'] ;
        print('PRODUCT ID 2 --->$productId :PRICE: $userDiscountPrice');

        discountedPrice=userDiscountPrice;
      }

    }


    return discountedPrice.toDouble();

  }



  /// submit an order data to firebase
  Future<void> uploadOrder(List<OrderItemsModel> orderedItemDetails,
      String totalInvoiceValue) async {
    String latestOrderId = '';
    String latestInvoiceNo = '';
    try {
      orderedItems.assignAll(orderedItemDetails);
      print('orderedItemDetails-1-->${orderedItemDetails.length}');
      print('totalInvoiceValue--- final---->$totalInvoiceValue');
      CollectionReference ordersCollection = _db.collection("orders");
      QuerySnapshot querySnapshot = await ordersCollection.orderBy('OrderId', descending: true).limit(1).get();
      print('orderedItemDetails-2--->${orderedItemDetails.length}');

      if (querySnapshot.docs.isNotEmpty) {
        print('-----3');

        // Retrieve the latest order ID
        latestOrderId = querySnapshot.docs.first['OrderId'];

        latestInvoiceNo = querySnapshot.docs.first['InvoiceNo'];

        print('previous invoice number --$latestInvoiceNo');

        // Extract the last four digits of the order ID (document ID)
        String lastEightDigit = latestOrderId.substring(
            latestOrderId.length - 8);

        String lastFourDigit = latestInvoiceNo.substring(
            latestInvoiceNo.length - 4);


        print('----lastFourDigit----$lastFourDigit');
        // Increment the last four digits
        int newOrderNumericPart = int.tryParse(lastEightDigit) ?? 0;
        int newInvoiceNumericPart = int.tryParse(lastFourDigit) ?? 0;

        newOrderNumericPart++;
        newInvoiceNumericPart++;

        print(newOrderNumericPart);
        print(newInvoiceNumericPart);

        latestInvoiceNo = 'INV_${DateTime
            .now()
            .year}${newInvoiceNumericPart.toString().padLeft(4, '0')}';
        latestOrderId = 'MO_${newOrderNumericPart.toString()}';
      }
      else {
        // If no orders exist, start with a default order ID (document ID)
        latestOrderId = 'MO-20240001';
        latestInvoiceNo = 'INV-${DateTime
            .now()
            .year}0001';
      }


      // Create a document with order details, including the array of product details
      print('orderedItemDetails--2->${orderedItemDetails.length}');


      print('orderedItemDetails 3.4 --->${orderedItemDetails.length}');
      print('USERID------------------->${localStorage.read('USERID')}');


      // Create a document with order details and products array
      await ordersCollection.doc(latestOrderId).set({
        'OrderId': latestOrderId,
        'InvoiceValue': totalInvoiceValue,
        'OrderDate': Timestamp.fromDate(DateTime.now()),
        'Products': orderedItems.map((item) => item.toJson()).toList(),
        'InvoiceNo': latestInvoiceNo,
        'UserId': localStorage.read('USERID')
      });
      savePdfToFirestoreStorage(orderedItems,latestOrderId,latestInvoiceNo);
    } on FirebaseException catch (e) {
      throw MOFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw MOPlatformException(e.code).message;
    } catch (e) {
      print(e.toString());
      throw 'Something went wrong. Please try again $e';
    }
  }

  /// Save a PDF TO FIREBASE STORAGE
  Future<void> savePdfToFirestoreStorage(List<OrderItemsModel> orderedItems,String orderID,String invoiceNo) async {
    try {
      // Generate PDF
      final Uint8List pdfBytes = await pdfBuilder(orderedItems);

      // Get a reference to the storage service
      final FirebaseStorage storage = FirebaseStorage.instance;

      // Create a reference to the PDF file in Firebase Cloud Storage
      final String fileName = 'invoice_${DateTime.now().millisecondsSinceEpoch}.pdf'; // Unique file name
      final Reference reference = storage.ref().child('/Orders/documents/Invoices/$fileName');

      // Upload the PDF file to Firebase Cloud Storage
      await reference.putData(pdfBytes);
      final url = await reference.getDownloadURL();
        print('url-->'+url);

      CollectionReference mailsend = _db.collection('mail');
      // Document data (fields)
      Map<String, dynamic> mailData = {
        'message': {
          'subject': 'Your Matt Ortho Order No: $orderID',
          'text': 'Dear Valuable Customer,\n\n  Your Order has been sent to Processing center for fulfillment.\n'
              'Please note your Order No: $orderID for further enquiry.\n'
              'Thanks\n'
              'orthotrade Team ',
          'attachments':{
            'filename':'$invoiceNo.pdf',
            'path':url
          }
        },

        'to': [localStorage.read('REMEMBER_ME_EMAIL')],
      };
      await mailsend.add(mailData);
      print('url ----------------->'+url);

    } catch (error) {
      // Show error dialog
      print(error);
    }
  }  @override

  Future<int> fetchOrdersCount() async {
    try {
      int ordersCount = 0;
      final snapshot = await _db.collection("orders").where(
          'UserId', isEqualTo: localStorage.read('USERID')).get();
      return ordersCount = snapshot.size;
    } on FirebaseAuthException catch (e) {
      throw MOFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MOFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MOFormatException();
    } on PlatformException catch (e) {
      throw MOPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<FormsModel>> searchProducts(String query) async {
    try {
      // Reference to the 'products' collection in Firestore
      CollectionReference formsCollection = FirebaseFirestore.instance
          .collection('forms');

      // Start with a basic query to search for products where the name contains the query
      Query queryRef = formsCollection;

      // Apply the search filter
      if (query.isNotEmpty) {
        print('query--->$query');
        query = query.toLowerCase(); // Convert the query to lowercase

        queryRef = queryRef
            .where('Active', isEqualTo: 'Y') // Adding the condition here
            .orderBy('SearchTerm', descending: false)
            .startAt([query])
            .endAt(['$query\uf8ff']);
      }


      // Execute the query
      QuerySnapshot querySnapshot = await queryRef.get();


      int str = querySnapshot.docs.length;
      print('Length --->$str');

      // Map the documents to ProductModel objects
      final products = querySnapshot.docs.map((doc) =>
          FormsModel.fromSnapshot(doc,'')).toList();
      // print(products[0].formName);
      return products;
    } on FirebaseException catch (e) {
      throw MOFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw MOPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<FormsModel>> fetchFormDetails() async {
    try {
      String ordersCount;
      final snapshot = await _db.collection("orders").where(
          'UserId', isEqualTo: localStorage.read('USERID')).get();
       ordersCount = snapshot.size.toString();

      // Reference to the 'products' collection in Firestore
      CollectionReference formsCollection = FirebaseFirestore.instance
          .collection('forms');

      // Start with a basic query to search for products where the name contains the query
      Query queryRef = formsCollection;

      // Only Active Forms Condition
      queryRef = queryRef
          .where('Active', isEqualTo: 'Y');


      // Execute the query
      QuerySnapshot querySnapshot = await queryRef.get();

      int str = querySnapshot.docs.length;

      // Map the documents to ProductModel objects
      final products = querySnapshot.docs.map((doc) =>
          FormsModel.fromSnapshot(doc,ordersCount)).toList();
      // print(products[0].formName);
      return products;
    } on FirebaseException catch (e) {
      throw MOFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw MOPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}

