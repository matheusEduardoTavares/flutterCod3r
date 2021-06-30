import 'package:flutter/material.dart';

///Para podermos passar um componente para uma 
///[AppBar], este componente deve implementar 
///o [PreferredSizeWidget]
class ResultadoWidget extends StatelessWidget implements PreferredSizeWidget {
  const ResultadoWidget({ 
    @required this.venceu,
    @required this.onReiniciar,
    Key key,
  }) : super(key: key);

  final bool venceu;
  final Function onReiniciar;

  Color _getColor() {
    if (venceu == null) {
      return Colors.yellow;
    } else if (venceu) {
      return Colors.green[300];
    }

    return Colors.red[300];
  }

  IconData _getIcon() {
    if (venceu == null) {
      return Icons.sentiment_satisfied;
    } else if (venceu) {
      return Icons.sentiment_very_satisfied;
    }

    return Icons.sentiment_very_dissatisfied;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: CircleAvatar(
            backgroundColor: _getColor(),
            child: IconButton(
              ///Este padding se não passado o 
              ///[EdgeInsets.zero] acaba deixando o 
              ///ícone em si sem estar centralizado
              padding: EdgeInsets.zero,
              icon: Icon(
                _getIcon(),
                color: Colors.black,
                size: 35,
              ),
              onPressed: onReiniciar,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(120);
}