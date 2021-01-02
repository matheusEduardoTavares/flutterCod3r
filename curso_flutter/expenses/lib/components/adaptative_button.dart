import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptativeButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const AdaptativeButton({
    this.label,
    this.onPressed
  });

  @override 
  Widget build(BuildContext context){
    return Platform.isIOS ? CupertinoButton(
      child: Text(label),
      onPressed: onPressed,
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
    ) : RaisedButton(
      color: Theme.of(context).primaryColor,
      textColor: Theme.of(context).textTheme.button.color,
      child: Text(label),
      onPressed: onPressed
    );
  }
}