import 'package:calculator_section_18/components/button.dart';
import 'package:flutter/material.dart';

class ButtonRow extends StatelessWidget {
  const ButtonRow({ 
    @required this.buttons,
    Key key,
  }) : super(key: key);

  final List<Button> buttons;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: buttons,
    );
  }
}