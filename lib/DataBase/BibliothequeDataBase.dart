import 'package:musee/DataBase/database.dart';
import 'package:sqflite/sqflite.dart';
import '../Model/Bibliotheque.dart';

class BibliothequeDataBase extends DatabaseProvider{
  BibliothequeDataBase._();
  static final BibliothequeDataBase instance = BibliothequeDataBase._();

  void create(Bibliotheque bibliotheque) async{
    final Database? db = await database;
    await  db!.insert(Bibliotheque.table, bibliotheque.toDatabaseJson(),conflictAlgorithm: ConflictAlgorithm.replace);
  }
  void edit(Bibliotheque bibliotheque) async{
    final Database? db = await database;
    await  db!.update(Bibliotheque.table, bibliotheque.toDatabaseJson(),where: "numMus = ? AND ISBN = ? ",whereArgs: [bibliotheque.numMus,bibliotheque.ISBN]);
  }
  void del(String numMus, String ISBN) async{
    final Database? db = await database;
    await  db!.delete(Bibliotheque.table,where: "numMus = ? AND ISBN = ? ",whereArgs: [numMus,ISBN]);
  }
  Future<List<Bibliotheque>> findAll() async {
    final Database? db = await database;
    final List<Map<String, dynamic>> map = await db!.query(Bibliotheque.table,orderBy: "numMus DESC, ISBN DESC");
    List<Bibliotheque> bibliotheques = List.generate(map.length, (i) {
      return Bibliotheque.fromDatabaseJson(map[i]);
    });
    return bibliotheques;
  }

}