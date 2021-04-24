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
      mainAxisAlignment: belongsToMe ? MainAxisAlignment.end :
        MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: belongsToMe ? Colors.grey[300] : 
              Theme.of(context).accentColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              ///Se a mensagem for minha irei querer que
              ///ela fique redonda, e se for de outra 
              ///pessoa vou querer que ela fique 
              ///quadrada,
              bottomLeft: belongsToMe ? Radius.circular(12) : 
                Radius.circular(0),
              bottomRight: belongsToMe ? Radius.circular(0) : 
                Radius.circular(12)
              ),
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
              color: belongsToMe ? Colors.black : 
                Theme.of(context).accentTextTheme.headline1.color,
            ),
          ),
        ),
      ],
    );
  }
}