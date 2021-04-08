import 'package:flutter/material.dart';
import 'package:great_places/providers/greate_places.dart';
import 'package:great_places/screens/place_form_screen.dart';
import 'package:great_places/screens/places_list_screen.dart';
import 'package:great_places/utils/app_routes.dart';
import 'package:great_places/utils/db_util.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotEnv;

Future<void> main() async {
  await dotEnv.load();

  ///Com essa nova arquitetura de inicializar o [sqflite] antes de inicializar
  ///a aplicação, é necessário usar o 
  ///[WidgetsFlutterBinding.ensureInitialized()] para que seja inicializado
  ///a ligação com o Flutter antes do [runApp]
  WidgetsFlutterBinding.ensureInitialized();
  await DbUtil.initializeDatabase();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        initialRoute: AppRoutes.PLACE_LIST,
        routes: {
          AppRoutes.PLACE_LIST: (ctx) => PlacesListScreen(),
          AppRoutes.PLACE_FORM: (ctx) => PlaceFormScreen(),
        },
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }
}