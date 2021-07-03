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
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buttons.fold<List<Widget>>(<Widget>[], (list, b) {
          if (list.isEmpty) {
            list.add(b);
          }
          else {
            list.addAll([SizedBox(width: 1,), b]);
          }
          
          return list;
        }
      ),
    ));
  }
}