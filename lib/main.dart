import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app.dart';
import 'data/repositories/authentication/authentication_repository.dart';
import 'firebase_options.dart';

Future<void> main() async {


  //Todo : Add Widgets Binding
  final WidgetsBinding widgetsBinding=WidgetsFlutterBinding.ensureInitialized();

  //Todo : Init Local Storage
  await GetStorage.init();

  //Todo: Await Native Splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);



  //Todo: Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then(
          (FirebaseApp value) => Get.put(AuthenticationRepository()));


  //Todo:Initialize Authentication

  runApp( DevicePreview(
    isToolbarVisible: true,
    devices: [
      Devices.ios.iPhone12,
      Devices.ios.iPhone13,
      Devices.android.onePlus8Pro,
      Devices.android.samsungGalaxyA50,
      Devices.android.samsungGalaxyNote20Ultra,
    ],
    builder: (context) => App(), // Wrap your app
  ),);
}