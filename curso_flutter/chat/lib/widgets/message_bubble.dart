import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
    this.message,
    this.belongsToMe,
    {
      this.key,
    }
  ): super(key: key);

  ///Como iremos trabalhar com vários elementos dentro
  ///de um [ListView] é interessantes usarmos a [key],
  ///pois com isso conseguimos ter a atualização dos 
  ///valores de forma correta e evitamos problemas de 
  ///excluir elementos, de estado.
  final Key key;
  final String message;
  final bool belongsToMe;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          width: 140,
          margin: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 16.0,
          ),
          child: Text(
            message,
            style: TextStyle(
              ///A partir da versão 1.17 acessamos 
              ///a cor do texto baseada no Accent
              ///pegando seu 
              ///[.accentTextTheme.headline1.color],
              ///é uma cor que contrasta bem com o 
              ///[AccentColor]
              color: Theme.of(context).accentTextTheme.headline1.color,
            ),
          ),
        ),
      ],
    );
  }
}