import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

typedef FunctionsTextField = void Function(String);

class AdaptativeTextField extends StatelessWidget {
  final TextEditingController controller;
  final InputDecoration androidDecoration;
  final BoxDecoration iosDecoration;
  final TextInputType keyboardType;
  final FunctionsTextField onChanged;
  final FunctionsTextField onSubmitted;
  final FocusNode focusNode;
  final VoidCallback onEditingComplete;
  final VoidCallback onTap;
  final bool readOnly;
  final bool autofocus;
  final String placeholder;

  const AdaptativeTextField({
    @required this.controller,
    this.androidDecoration,
    this.iosDecoration,
    this.keyboardType,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.onEditingComplete,
    this.onTap,
    this.readOnly = false,
    this.autofocus = false,
    this.placeholder
  }) : assert(
    (iosDecoration != null && placeholder != null) || (iosDecoration == null),
    'É obrigatório ter um placeholder quando se está usando a decoração do iOS'
  );

  @override 
  Widget build(BuildContext context){
    return Platform.isIOS ? CupertinoTextField(
      placeholder: placeholder,
      controller: controller,
      decoration: iosDecoration,
      focusNode: focusNode,
      keyboardType: keyboardType,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
      onTap: onTap,
      autofocus: autofocus ?? false,
      readOnly: readOnly ?? false,
    ) : TextField(
      controller: controller,
      decoration: androidDecoration,
      focusNode: focusNode,
      keyboardType: keyboardType,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
      onTap: onTap,
      autofocus: autofocus ?? false,
      readOnly: readOnly ?? false,
    );
  }
}