import 'package:flutter/material.dart';
import '../utils/app_routes.dart';

class MainDrawer extends StatelessWidget {
  Widget _createItem(IconData icon, String label, {VoidCallback onTap, String routeName = AppRoutes.HOME, BuildContext context}){
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        label,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        )
      ),
      onTap: onTap ?? () => Navigator.of(context).pushNamed(routeName)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget> [
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: Theme.of(context).accentColor,
            alignment: Alignment.bottomRight,
            child: Text(
              'Vamos Cozinhar?',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Theme.of(context).primaryColor,
              )
            ),
          ),
          SizedBox(height: 20,),
          _createItem(
            Icons.restaurant, 
            'Refeições',
            onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.HOME)
          ),
          _createItem(
            Icons.settings, 
            'Configurações',
            routeName: AppRoutes.SETTINGS,
            context: context
          ),
        ]
      )
    );
  }
}