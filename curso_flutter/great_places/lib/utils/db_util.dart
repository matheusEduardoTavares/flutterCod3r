import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

abstract class DbUtil {

  static sql.Database _sqflite;

  static const databaseName = 'places.db';

  static const tableName = 'places';

  static Future<void> initializeDatabase() async {
    ///Caminho onde é armazenado o caminho do 
    ///banco de dados
    final dbPath = await sql.getDatabasesPath();

    ///Por fim retornamos o banco em si, passando 
    ///para ele o nome completo, desde seu path 
    ///até o nome do banco em si. Ao retornar o 
    ///resultado do método [openDatabase] será chamado
    ///o método [onCreate] que é um dos parâmetros que
    ///passamos para ele. Assim tanto para criar a 
    ///primeira vez o banco quanto para pegar a instância
    ///com os dados já presentes, acabamos tendo que 
    ///executar este mesmo método. Esse método 
    ///[onCreate] recebe o banco em si e a versão dele,
    ///pois podemos trabalhar com múltiplas versões.
    ///Dentro dessa função, é onde executaremos o 
    ///DDL p/ criar a tabela onde iremos guardar 
    ///os dados. No caso da tabela que criaremos, será 
    ///pará armazenar os dados do formulário, de forma que
    ///será salvo o caminho da imagem, o ID do local e 
    ///o seu título. Salvamos a imagem no path usando
    ///o [path_provider].
    _sqflite = await sql.openDatabase(
      path.join(dbPath, databaseName),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $tableName (id TEXT PRIMARY KEY, title TEXT, image TEXT)'
        );
      },
      version: 1,
    );
  }

  ///recebe a tabela e um [Map] com o nome da coluna como
  ///key e o valor como value.
  static Future<void> insert(String table, Map<String, dynamic> data) async {
    ///Pegamos a instância do banco e usamos o método
    ///[insert] passando para ele o nome da tabela, 
    ///os dados que queremos inserir e temos mais alguns
    ///parâmetros nomeados opcionais como o [conflictAlgorithm],
    ///que é quando caso eventualmente esteja inserindo algo
    ///no banco de dados que deu um conflito, ou seja, 
    ///já tem um registro com um mesmo ID por exemplo, 
    ///e no caso usaremos para ele o valor 
    ///[ConflictAlgorithm.replace] para que o dado seja
    ///substituído
    await _sqflite.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }
}