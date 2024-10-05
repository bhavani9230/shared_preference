import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextDecoration? decoration;
  final int? maxLines;
  final TextOverflow overflow;
  final double? letterspacing;

  const CustomText({
    Key? key,
    required this.text,
    this.fontSize = 14.0,
    this.color,
    this.fontWeight,
    this.textAlign,
    this.decoration,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
    this.letterspacing
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(

      text,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight ?? FontWeight.normal,
        decoration: decoration,
        letterSpacing: letterspacing
      ),
      textAlign: textAlign,
      maxLines: maxLines ?? 2,
      overflow: overflow,

    );
  }
}
