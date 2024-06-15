import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orthotrade/features/authentication/models/user_model.dart';

import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../authentication/authentication_repository.dart';

class UserRepository extends GetxController {


  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;


  /// Function to save user data to FireStore

  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
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

  /// Function to fetch user details based on user ID
  Future<UserModel> fetchUserDetails() async {
    try {
     // Since its cloud query we should use await
      print(AuthenticationRepository.instance.getUserID);

      final documentSnapshot  = await _db.collection("users").doc(AuthenticationRepository.instance.getUserID).get();
      print(documentSnapshot.get('Email'));
      if(documentSnapshot.exists){
        print('222222');
        return UserModel.fromSnapshot(documentSnapshot);
      }else{
        return UserModel.empty();
      }
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
/// Function to update user data in Firestore

  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _db.collection("Users").doc(updatedUser.id).update(updatedUser.toJson());
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
/// Update any field in specific Users Collection

  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db.collection("users").doc(AuthenticationRepository.instance.authUser?.uid).update(json);
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


/// Function to upload image
  Future<String> uploadImage(String path,XFile image) async {
    try {

      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;



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

}
