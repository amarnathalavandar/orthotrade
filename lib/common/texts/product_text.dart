import 'package:flutter/material.dart';

class MOProductNameText extends StatelessWidget {
  const MOProductNameText({super.key,
    required this.name,
    this.smallSize =false,
    this.maxLine=2,
    this.textAlign = TextAlign.left});


  final String name;
  final bool smallSize;
  final int maxLine;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return  Text(
      name,
      style: smallSize ?
      Theme.of(context).textTheme.bodySmall
          :Theme.of(context).textTheme.bodyMedium,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLine,
      textAlign: textAlign,
    );
  }
}
