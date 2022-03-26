import 'package:musee/DataBase/database.dart';
import 'package:sqflite/sqflite.dart';
import '../Model/Musee.dart';

class MuseeDataBase extends DatabaseProvider{
  static final MuseeDataBase instance = MuseeDataBase._();
  MuseeDataBase._();

  void create(Musee musee) async{
    final Database? db = await database;
    await  db!.insert(Musee.table, musee.toDatabaseJson(),conflictAlgorithm: ConflictAlgorithm.replace);
  }
  void edit(Musee musee) async{
    final Database? db = await database;
    await  db!.update(Musee.table, musee.toDatabaseJson(),where: "numMus = ?",whereArgs: [musee.numMus]);
  }
  void del(String numMus) async{
    final Database? db = await database;
    await  db!.delete(Musee.table,where: "numMus = ?",whereArgs: [numMus]);
  }
  Future<List<Musee>> findAll() async {
    final Database? db = await database;
    final List<Map<String, dynamic>> map = await db!.query(Musee.table);
    List<Musee> musees = List.generate(map.length, (i) {
      return Musee.fromDatabaseJson(map[i]);
    });
    return musees;
  }
}