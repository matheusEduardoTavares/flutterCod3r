import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shop/widgets/auth_card.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ///Para fazer o login automático, precisaremos persistir
    ///os dados do token, data de expiração e o ID do usuário,
    ///para depois quando sairmos da aplicação e voltarmos ela
    ///permanecer logada sem precisar fazer login novamente.
    ///Temos várias libs para fazer isso, como o [shared_preferences],
    ///o [flutter_secure_storage], o [hive] que é um banco 
    ///no-sql e roda dentro do dispositivo em armazenamento 
    ///local. No caso usaremos o [shared_preferences] pois ele 
    ///é mais simples.

    ///Outro exemplo de uso do [cascade operator] é quando 
    ///precisamos adicionar vários itens na lista, como o método
    ///[add] retorna void, não conseguimos o chamar duas vezes
    ///seguidas com o operador ponto, aí precisamos do cascade.
    ///O dado que será retornado é quem está antes do cascade 
    ///operator, no caso abaixo, a lista [a].
    // List a = [1, 2, 3];
    // var res = a..add(1)..add(2)..add(3);
    // print('res = $res');

    return Scaffold(
      body: Stack(
        children: [
          ///Foi usado um [Stack] e um [Container] para fazer
          ///o background da página com um gradiente.
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(215, 117, 255, 0.5),
                  Color.fromRGBO(255, 188, 117, 0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20.0),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 70,
                  ),
                  ///O método [rotationZ] do [Matrix4] é usado
                  ///para rotacionar o elemento no eixo Z, e 
                  ///com isso conseguimos deixá-lo inclinado.
                  ///Mas nesse caso queremos fazer com que ele 
                  ///seja transladado em -10 também, usando o 
                  ///método [translate(-10)], porém, esse método
                  ///[translate] retorna void, e não podemos passar
                  ///void para o transform. Sendo assim, precisaremos
                  ///usar o operador .. ao invés do . , é o operador
                  ///chamado [cascade operator]. Com esse cascade, 
                  ///conseguimos chamar e executar uma função, porém
                  ///aquela função chamada com o .. não é retornada, 
                  ///apenas é executada, sendo assim, chamando o 
                  ///[rotationZ] com o operador ponto e depois o 
                  ///[translate] com o cascade operator, quem será 
                  ///retornado para o [transform] é o [rotationZ], e
                  ///o [translate] apenas será executado fazendo a 
                  ///translação que queremos
                  transform: Matrix4.rotationZ(-8 * pi / 180)
                  ///Se passarmos um inteiro para o [translate]
                  ///irá quebrar, sempre devemos passar double
                    ..translate(-10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    ///O [.shade900] serve para deixar a cor mais escura
                    color: Colors.deepOrange.shade900,
                    boxShadow: [
                      BoxShadow(
                        ///Para borrar a sombra
                        blurRadius: 8,
                        color: Colors.black26,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    'Minha Loja',
                    style: TextStyle(
                      color: Theme.of(context).accentTextTheme.headline6.color,
                      fontSize: 45,
                      fontFamily: 'Anton'
                    ),
                  ),
                ),
                AuthCard()
              ],
            ),
          ),
        ],
      ),
    );
  }
}