import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/auth.dart';
import '../utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Bem vindo Usuário!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Loja'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.AUTH_HOME,
              );
            }
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Pedidos'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.ORDERS,
              );
            }
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Gerenciar Produtos'),
            onTap: () {
              ///Ao invés de usar o [pushReplacementNamed],
              ///podemos usar o [pushReplacement] e aí temos
              ///que trabalhar com o [MaterialPageRoute].
              ///Criaremos uma classe que irá extender o 
              ///[MaterialPageRoute] para podermos
              ///personalizar nossas rotas.
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.PRODUCTS,
              );
              /// E aí a forma de usar seria assim:
              // Navigator.of(context).pushReplacement(
              //   CustomRoute(
              //     builder: (ctx) => ProductsScreen(),
              //     settings: RouteSettings(
              //       name: AppRoutes.PRODUCTS
              //     ),
              //   )
              // );
            }
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sair'),
            onTap: () {
              Provider.of<Auth>(context, listen: false).
                logout();

              Navigator.of(context)
                .pushReplacementNamed(AppRoutes.AUTH_HOME);
            }
          ),
        ],
      )
    );
  }
}