import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:orthotrade/features/authentication/screens/onboarding/onboarding.dart';

import '../../../features/authentication/screens/login/login.dart';
import '../../../features/authentication/screens/signup/verify_email.dart';
import '../../../navigation_menu.dart';
import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';


class AuthenticationRepository extends GetxController {


  static AuthenticationRepository get instance => Get.find();

  /// Variables
  final deviceStorage = GetStorage();
  late final Rx<User?> _firebaseUser;
  final _auth = FirebaseAuth.instance;
  User? get authUser=>_auth.currentUser;

  User? get firebaseUser => _firebaseUser.value;

  String get getUserID => _firebaseUser.value?.uid ?? "";

  /// Called from main.dart on app launch
  @override
  void onReady() {
    _firebaseUser = Rx<User?>(_auth.currentUser);
    _firebaseUser.bindStream(_auth.userChanges());
    FlutterNativeSplash.remove();
    screenRedirect(_firebaseUser.value);
  }

  /// Function to show relevant screen based on first time login
  screenRedirect(User? user) async {

    if (user != null) {
      print('emails ver');
      print(user.emailVerified);
      print('----userID---');
      print(getUserID);
      print('done');
      // If the user is logged in
      if (user.emailVerified) {
        // If the user's email is verified, navigate to the main Navigation Menu
        Get.offAll(() => const NavigationMenu());
      } else {
         //If the user's email is  not verified, navigate to the Verify Email Menu
        Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email));
      }
    } else {
      // Local Storage
      deviceStorage.writeIfNull('isFirstTime', true);

      //check if its the first time launching the app
      deviceStorage.read('isFirstTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(() => const OnBoardingScreen());
    }
  }

  /*------------------------- Email & Password Sign In ------------------------*/

  /// Email Authentication - Login
  ///
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
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



  /// Email Authentication - Register

  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
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

  /// Email Authentication - Mail Verification


  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
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


  /// Email Authentication - ReAuthenticate User
/*
  Future<void> reAuthenticateWithEmailAndPassword(String email,String password) async {
    try {
    AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);

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

  /// /// Email Authentication - Forget Password

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
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


/*------------------------- Federated identity & Social Sign In ------------------------*/

  /// Email Authentication - Google

/*
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth=await userAccount?.authentication;
      //Create a new credential
      final credentials= GoogleAuthProvider.credential(accessToken: googleAuth?.accessToken,idToken: googleAuth?.idToken);
      //Once Signed in return the UserCredentials
      return await _auth.signInWithCredential(credentials);


    } on FirebaseAuthException catch (e) {
      throw MOFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MOFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MOFormatException();
    } on PlatformException catch (e) {
      throw MOPlatformException(e.code).message;
    } catch (e) {
      if(kDebugMode) print('Something Went Wrong: $e');
      return null;
    }
  }
*/

  /// Email Authentication - Facebook

/*------------------------- ./ END of Federated Identity & Social Sign in ------------------------*/

  /// Logout
  Future<void> logout() async {
    try {
      //await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();

      Get.offAll(() => const LoginScreen());
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
/// Delete Account


/*
  Future<void> deleteAccount() async {
    try {
        await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
        await _auth.currentUser?.delete();
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



}
