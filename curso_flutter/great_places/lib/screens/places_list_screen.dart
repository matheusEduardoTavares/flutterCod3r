import 'package:flutter/material.dart';
import 'package:great_places/providers/greate_places.dart';
import 'package:great_places/utils/app_routes.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Lugares'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context)
                .pushNamed(AppRoutes.PLACE_FORM);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        ///Aqui deixamos o [listen] false pois é o [FutureBuilder]
        ///que irá saber quando precisa atualizar a árvore de
        ///componentes
        future: Provider.of<GreatPlaces>(context, listen: false)
          .loadPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState 
          == ConnectionState.waiting ? Center(
            child: LinearProgressIndicator(),
          ) : Consumer<GreatPlaces>(
                child: Center(
                  child: Text('Nenhum local cadastrado!'),
                ),
                builder: (ctx, greatPlaces, ch) => greatPlaces.itemsCount == 0 ?
                  ch : ListView.builder(
                    itemCount: greatPlaces.itemsCount,
                    itemBuilder: (ctx, index) => ListTile(
                      leading: CircleAvatar(
                        backgroundImage: FileImage(
                          greatPlaces.itemByIndex(index).image
                        ),
                      ),
                      title: Text(greatPlaces.itemByIndex(index).title),
                      onTap: () {},
                    ),
                  ),
              )
      ),
    );
  }
}