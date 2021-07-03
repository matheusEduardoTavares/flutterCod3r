import 'package:calculator_section_18/components/button.dart';
import 'package:calculator_section_18/components/button_row.dart';
import 'package:flutter/material.dart';

class Keyboard extends StatelessWidget {
  const Keyboard({ 
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: Column(
        children: [
          ButtonRow(
            buttons: [
              Button(
                text: '7',
              ),
              Button(
                text: '8',
              ),
              Button(
                text: '9',
              ),
            ],
          ),
          ButtonRow(
            buttons: [
              Button(
                text: '4',
              ),
              Button(
                text: '5',
              ),
              Button(
                text: '6',
              ),
            ],
          ),
        ],
      ),
    );
  }
}