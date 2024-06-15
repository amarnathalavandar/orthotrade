import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:orthotrade/utils/theme/theme.dart';
import 'bindings/general_bindings.dart';
import 'features/authentication/screens/login/login.dart';

class App extends StatelessWidget {
  const App
      ({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: GeneralBindings(),
      themeMode: ThemeMode.system,
      theme:MOAppTheme.lightTheme,
      darkTheme: MOAppTheme.darkTheme,
      home:const LoginScreen(),

    ) ;
  }
}


