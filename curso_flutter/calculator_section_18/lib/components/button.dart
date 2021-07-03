import 'package:flutter/material.dart';

typedef CallbackOnTap = void Function(String);

class Button extends StatelessWidget {
  const Button({ 
    @required this.text,
    @required this.cb,
    this.big = false,
    this.color = DEFAULT,
    Key key,
  }) : super(key: key);

  const Button.big({ 
    @required this.text,
    @required this.cb,
    this.big = true,
    this.color = DEFAULT,
    Key key,
  }) : super(key: key);

  const Button.operation({ 
    @required this.text,
    @required this.cb,
    this.big = false,
    this.color = OPERATION,
    Key key,
  }) : super(key: key);

  static const DARK = Color.fromRGBO(82, 82, 82, 1);
  static const DEFAULT = Color.fromRGBO(112, 112, 112, 1);
  static const OPERATION = Color.fromRGBO(250, 158, 13, 1);
  final String text;
  final bool big;
  final Color color;
  final CallbackOnTap cb;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: big ? 2 : 1,
      child: ElevatedButton(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.w200,
          ),
        ),
        onPressed: () => cb(text),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            color,
          ),
          foregroundColor: MaterialStateProperty.all(
            Colors.black,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
        ),
      ),
    );
  }
}