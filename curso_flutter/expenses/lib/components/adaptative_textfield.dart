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
  final String label;
  final EdgeInsets paddingOutside;
  final EdgeInsets paddingInside;

  const AdaptativeTextField({
    @required this.controller,
    this.androidDecoration,
    this.iosDecoration,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.onEditingComplete,
    this.onTap,
    this.readOnly = false,
    this.autofocus = false,
    this.placeholder,
    this.label,
    this.paddingInside,
    this.paddingOutside
  }) : assert(
    (iosDecoration != null && placeholder != null) || (iosDecoration == null),
    'É obrigatório ter um placeholder quando se está usando a decoração do iOS'
  );

  Widget _getCupertinoTextField(bool hasIosDecoration) {
    return hasIosDecoration ? CupertinoTextField(
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
      padding: paddingInside ?? EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 12
      ),
    ) : CupertinoTextField(
      placeholder: placeholder,
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
      onTap: onTap,
      autofocus: autofocus ?? false,
      readOnly: readOnly ?? false,
      padding: paddingInside ?? EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 12
      ),
    );
  }

  @override 
  Widget build(BuildContext context){
    return Platform.isIOS ? Padding(
      padding: paddingOutside ?? const EdgeInsets.only(
        bottom: 10
      ),
      child: _getCupertinoTextField(iosDecoration != null),
    ) : TextField(
      controller: controller,
      decoration: androidDecoration ?? InputDecoration(
        labelText: label
      ),
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