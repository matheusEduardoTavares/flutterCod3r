import 'package:flutter/material.dart';
import '../components/main_drawer.dart';
import '../models/settings.dart';

typedef OnChanged = void Function(bool);

class SettingsScreen extends StatefulWidget {
  final Settings settings;

  final Function(Settings) onSettingsChanged;

  const SettingsScreen(
    this.settings,
    this.onSettingsChanged
  );

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Settings _settings;

  @override 
  void initState(){
    super.initState();

    _settings = widget.settings ?? Settings();
  }

  Widget _createSwitch(
    String title, 
    String subtitle, 
    bool value, 
    OnChanged onChanged,
  ){
    return SwitchListTile.adaptive(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: (value) {
        onChanged(value);
        widget.onSettingsChanged(_settings);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget> [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Configurações',
              style: Theme.of(context).textTheme.headline6,
            )
          ),
          Expanded(
            child: ListView(
              children: <Widget> [
                _createSwitch(
                  'Sem Glutén',
                  'Só exibe refeições sem glúten!',
                  _settings.isGlutenFree,
                  (value) => setState(() {
                    _settings.isGlutenFree = value;
                  })
                ),
                _createSwitch(
                  'Sem Lactose',
                  'Só exibe refeições sem lactose!',
                  _settings.isLactoseFree,
                  (value) => setState(() {
                    _settings.isLactoseFree = value;
                  })
                ),
                _createSwitch(
                  'Vegana',
                  'Só exibe refeições veganas!',
                  _settings.isVegan,
                  (value) => setState(() {
                    _settings.isVegan = value;
                  })
                ),
                _createSwitch(
                  'Vegetariana',
                  'Só exibe refeições vegetarianas!',
                  _settings.isVegetarian,
                  (value) => setState(() {
                    _settings.isVegetarian = value;
                  })
                ),
              ],
            ),
          )
        ]
      )
    );
  }
}