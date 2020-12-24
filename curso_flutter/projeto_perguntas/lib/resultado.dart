import 'package:flutter/material.dart';

class Resultado extends StatelessWidget {
  final Widget content;
  final String text;
  final double widthFactor;
  final double heightFactor;
  final TextStyle textStyle;
  final int maxLines;
  final TextOverflow overflow;
  final TextAlign textAlign;
  final bool softWrap;

  const Resultado({
    Key key,
    this.content,
    this.text,
    this.widthFactor,
    this.heightFactor,
    this.textStyle,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.softWrap
  }) : super(key: key);

  @override 
  Widget build(BuildContext context){
    return Center(
      heightFactor: heightFactor,
      widthFactor: widthFactor,
      child: content ?? Text(
        text ?? 'Parabéns!',
        style: textStyle ?? TextStyle(fontSize: 28),
        maxLines: maxLines,
        overflow: overflow,
        textAlign: textAlign,
        softWrap: softWrap
      ),
    );
  }
}