import 'package:flutter/material.dart';

class CustomPageTransitionBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context, 
    Animation<double> animation, 
    Animation<double> secondaryAnimation, 
    Widget child,
  ) {
    ///Podemos fazer essas validações de rotas também
    // if (route.settings.name == '/') {
    //   return child;
    // }

    ///Mas nesse caso queremos retornar sempre a 
    ///animação de [FadeTransition] para todas as 
    ///rotas.
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}