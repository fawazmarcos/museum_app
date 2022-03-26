import 'package:musee/DataBase/database.dart';
import 'package:sqflite/sqflite.dart';
import '../Model/Ouvrage.dart';

class OuvrageDataBase extends DatabaseProvider{
  static final OuvrageDataBase instance = OuvrageDataBase._();
  OuvrageDataBase._();

  void create(Ouvrage ouvrage) async{
    final Database? db = await database;
    await  db!.insert(Ouvrage.table, ouvrage.toDatabaseJson(),conflictAlgorithm: ConflictAlgorithm.replace);
  }
  void edit(Ouvrage ouvrage) async{
    final Database? db = await database;
    await  db!.update(Ouvrage.table, ouvrage.toDatabaseJson(),where: "ISBN = ?",whereArgs: [ouvrage.ISBN]);
  }
  void del(String ISBN) async{
    final Database? db = await database;
    await  db!.delete(Ouvrage.table,where: "ISBN = ?",whereArgs: [ISBN]);
  }
  Future<List<Ouvrage>> findAll() async {
    final Database? db = await database;
    final List<Map<String, dynamic>> map = await db!.query(Ouvrage.table);
    List<Ouvrage> ouvrages = List.generate(map.length, (i) {
      return Ouvrage.fromDatabaseJson(map[i]);
    });
    return ouvrages;
  }
}