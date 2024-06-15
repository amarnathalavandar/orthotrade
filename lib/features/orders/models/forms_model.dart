import 'package:flutter/material.dart';


import 'package:cloud_firestore/cloud_firestore.dart';

class FormsModel {
  FormsModel(
      {
        required this.id,
        required this.formName,
         required this.active,
        required this.count
     });

  /// Keep those values final which yo don't want to update
  final String id;

  String formName;
  String active;
  String count;



  /// Static function to create an empty Products Model

  static FormsModel empty() => FormsModel(
    id: '',
    formName: '',
    active: '',
    count:''

  );


  /// Factory method to create a UserModel from a Firebase document snapshot

  factory FormsModel.fromSnapshot(
      DocumentSnapshot<Object?> document , String ordersCount) {
    if (document.data() != null) {
      final data = document.data() as Map<String, dynamic>;
      if(data['FormName']!='Products Order Form') {
        ordersCount='0';
      }
      return FormsModel(
        id: document.id,
        formName: data['FormName'] ?? '',
        active: data['Active'] ?? '',
        count:ordersCount
      );
    } else {
      return FormsModel.empty();
    }
  }
}
