import 'package:flutter/material.dart';

class MOProductTitleText extends StatelessWidget {
  const MOProductTitleText({super.key,
    required this.title,
     this.smallSize =false,
     this.maxLine=2,
    this.textAlign = TextAlign.left});


  final String title;
  final bool smallSize;
  final int maxLine;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return  Text(
      title,
      style: smallSize ?
      Theme.of(context).textTheme.bodySmall
          :Theme.of(context).textTheme.titleMedium,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLine,
      textAlign: textAlign,
    );
  }
}
