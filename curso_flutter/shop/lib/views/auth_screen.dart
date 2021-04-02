import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shop/widgets/auth_card.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
          ///Caso alguma hora ao fazermos um wrap do 
          ///[SingleChildScrollView] com um [Center], acabar
          ///algum elemento aparecendo só uma parte sua, sendo
          ///que a outra acaba sendo cortada, para resolver 
          ///de forma simples isso é só por um [SizedBox] com 
          ///alguma propriedade que leve o elemento mais para
          ///baixo ou mais para o lado segundo o que está 
          ///ficando de fora
          Center(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 45),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20.0),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 70,
                      ),
                      transform: Matrix4.rotationZ(-8 * pi / 180)
                        ..translate(-10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepOrange.shade900,
                        boxShadow: [
                          BoxShadow(
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
            ),
          ),
        ],
      ),
    );
  }
}