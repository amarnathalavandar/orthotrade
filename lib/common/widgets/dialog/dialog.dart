import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../data/repositories/authentication/authentication_repository.dart';



class MODialog extends StatelessWidget {
  const MODialog({super.key, required this.title, required this.message,
     this.buttonText='Okay', this.nextScreen='navigationmenu'});

final String title;
final String message;
final String buttonText;
 final String nextScreen;

  @override
  Widget build(BuildContext context) {

    final controller = AuthenticationRepository.instance;
    return  AlertDialog(
      title:  Text(title,style:TextStyle(color: Colors.red.shade900)),
      content:  SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
             const SizedBox(height: 10,),
            Text(message,style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child:  Text(buttonText),
          onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        )


      ],
    );
  }
}


