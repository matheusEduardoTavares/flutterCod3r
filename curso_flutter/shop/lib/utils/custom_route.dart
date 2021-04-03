import 'package:flutter/material.dart';

class CustomRoute<T> extends MaterialPageRoute<T> {
  ///Pegaremos apenas os 2 atributos que não são 
  ///opcionais para podermos passá-lo para o 
  ///[MaterialPageRoute]
  CustomRoute({
    @required WidgetBuilder builder,
    RouteSettings settings,
  }) : super(
    builder: builder, 
    settings: settings
  );

  ///Agora iremos sobrescrever o método [buildTransitions],
  ///pois é ele o único método que nos interessa para
  ///mudar essa animação
  @override
  Widget buildTransitions(
    BuildContext context, 
    Animation<double> animation, 
    Animation<double> secondaryAnimation, 
    Widget child,
  ) {
    ///Exemplo retornando para uma dada rota a página
    ///sem animação
    if (settings.name == '/') {
      return child;
    }

    ///Agora se quisermos animar podemos usar uma 
    ///Transition como por exemplo o [FadeTransition],
    ///na qual sua [opacity] é o parâmetro 
    ///[animation]
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}