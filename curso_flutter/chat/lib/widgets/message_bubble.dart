import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
    this.message,
    this.userName,
    this.userImage,
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
  final String userName;
  final String userImage;
  final String message;
  final bool belongsToMe;

  @override
  Widget build(BuildContext context) {
    Color _defaultTextColor = belongsToMe ? Colors.black : 
      Theme.of(context).accentTextTheme.headline1.color;

    return Stack(
      children: [
        Row(
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
                vertical: 12,
                horizontal: 8,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 16.0,
              ),
              child: Column(
                crossAxisAlignment: belongsToMe ? 
                  CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  ///Essa primeira estratégia que usamos para 
                  ///mostrar o nome do usuário responsável 
                  ///pela mensagem não é das melhores, 
                  ///pois embora seja feito cache das informações,
                  ///para cada mensagem teremos um [FutureBuilder]
                  ///fazendo uma chamada no [Firebase], e não é 
                  ///uma estratégia muito interessante, pois apesar
                  ///que será feito esses carregamentos apenas para
                  ///as mensagens que estão aparecendo na tela,
                  ///toda hora ficaríamos requisitando coisas.
                  ///Por isso é interessante passar por parâmetro 
                  ///o nome do usuário. Por isso uma estratégia 
                  ///legal para se fazer é colocar o nome do 
                  ///usuário no momento que formos criar uma 
                  ///nova mensagem. Iremos replicar os dados 
                  ///pois salvaremos em vários locais o nome
                  ///do usuário, mas quando trabalhamos com 
                  ///banco não relacionais, acabamos tendo
                  ///essas replicações de dados. Ganhamos 
                  ///praticidade e escalabilidade muito 
                  ///maior que em um banco relacional,
                  ///mas tem os lados negativos como
                  ///esse de replicação dos dados
                  // FutureBuilder(
                  //   future: Firestore.instance.collection('users')
                  //     .document(userName).get(),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.connectionState == ConnectionState.waiting) {
                  //       return Text('Loading...');
                  //     }

                  //     return Text(
                  //       snapshot.data['name'],
                  //       style: TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //         color: _defaultTextColor,
                  //       ),
                  //     );
                  //   }
                  // ),
                  ///Agora passamos a persistir o nome do 
                  ///usuário ao criar uma nova mensagem, e 
                  ///fica muito mais fácil obter o nome do 
                  ///usuário aqui, pois o pegamos junto da 
                  ///mensagem e é só passar por parâmetro
                  Text(
                    userName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _defaultTextColor,
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      ///A partir da versão 1.17 acessamos 
                      ///a cor do texto baseada no Accent
                      ///pegando seu 
                      ///[.accentTextTheme.headline1.color],
                      ///é uma cor que contrasta bem com o 
                      ///[AccentColor]
                      color: _defaultTextColor,
                    ),
                    textAlign: belongsToMe ? 
                      TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: belongsToMe ? null : 128.0,
          right: belongsToMe ? 128.0 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              this.userImage,
            ),
          ),
        ),
      ],
    );
  }
}