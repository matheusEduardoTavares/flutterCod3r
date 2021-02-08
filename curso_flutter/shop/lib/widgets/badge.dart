import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  Badge({
    @required this.child,
    @required this.value,
    this.color
  });

  final Widget child;
  final String value;
  final Color color;

  @override 
  Widget build(BuildContext context) {
    //Com a stack conseguimos por um elemento em cima
    //do outro, por isso a usaremos aqui
    return Stack(
      alignment: Alignment.center,
      children: <Widget> [
        //Primeiros elementos ficam em baixo, e os 
        //próximos ficam em cima
        child,
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            padding: EdgeInsets.all(2),
            height: 15,
            width: 15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: color != null ? color : Theme.of(context).accentColor,
            ),
            constraints: BoxConstraints(
              maxHeight: 16,
              minHeight: 16,
            ),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10
              )
            ),
          )
        )
      ]
    );
  }
}