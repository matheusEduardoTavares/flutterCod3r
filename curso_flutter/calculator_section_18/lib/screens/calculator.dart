import 'package:calculator_section_18/components/keyboard.dart';
import 'package:calculator_section_18/models/memory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/display.dart';

class Calculator extends StatefulWidget {
  const Calculator({ 
    Key key,
  }) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final _memory = Memory();

  void _onPressed(String command) {
    setState(() {
      _memory.applyCommand(command);
    });
  }

  @override
  Widget build(BuildContext context) {
    ///Setando para manter a aplicação sempre em 
    ///modo retrato para cima
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      home: Column(
        children: [
          Display(
            _memory.value,
          ),
          Keyboard(
            cb: _onPressed,
          ),
        ],
      ),
    );
  }
}