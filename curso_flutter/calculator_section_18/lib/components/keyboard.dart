import 'package:calculator_section_18/components/button.dart';
import 'package:calculator_section_18/components/button_row.dart';
import 'package:flutter/material.dart';
import '../components/button.dart';

class Keyboard extends StatelessWidget {
  const Keyboard({ 
    @required this.cb,
    Key key,
  }) : super(key: key);

  final CallbackOnTap cb;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: Column(
        children: [
          ButtonRow(
            buttons: [
              Button.big(
                text: 'AC',
                color: Button.DARK,
                cb: cb,
              ),
              Button(
                text: '%',
                color: Button.DARK,
                cb: cb,
              ),
              Button.operation(
                text: '/',
                cb: cb,
              ),
            ],
          ),
          const SizedBox(height: 1),
          ButtonRow(
            buttons: [
              Button(
                text: '7',
                cb: cb,
              ),
              Button(
                text: '8',
                cb: cb,
              ),
              Button(
                text: '9',
                cb: cb,
              ),
              Button.operation(
                text: 'x',
                cb: cb,
              ),
            ],
          ),
          const SizedBox(height: 1),
          ButtonRow(
            buttons: [
              Button(
                text: '4',
                cb: cb,
              ),
              Button(
                text: '5',
                cb: cb,
              ),
              Button(
                text: '6',
                cb: cb,
              ),
              Button.operation(
                text: '-',
                cb: cb,
              ),
            ],
          ),
          const SizedBox(height: 1),
          ButtonRow(
            buttons: [
              Button(
                text: '1',
                cb: cb,
              ),
              Button(
                text: '2',
                cb: cb,
              ),
              Button(
                text: '3',
                cb: cb,
              ),
              Button.operation(
                text: '+',
                cb: cb,
              ),
            ],
          ),
          const SizedBox(height: 1),
          ButtonRow(
            buttons: [
              Button.big(
                text: '0',
                cb: cb,
              ),
              Button(
                text: '.',
                cb: cb,
              ),
              Button.operation(
                text: '=',
                cb: cb,
              ),
            ],
          ),
        ],
      ),
    );
  }
}