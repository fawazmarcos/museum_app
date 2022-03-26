import 'package:musee/DataBase/database.dart';
import 'package:sqflite/sqflite.dart';
import '../Model/Visiter.dart';

class VisiterDataBase extends DatabaseProvider{
  static final VisiterDataBase instance = VisiterDataBase._();
  VisiterDataBase._();

  void create(Visiter visiter) async{
    final Database? db = await database;
    await  db!.insert(Visiter.table, visiter.toDatabaseJson(),conflictAlgorithm: ConflictAlgorithm.replace);
  }
  void edit(Visiter visiter) async{
    final Database? db = await database;
    await  db!.update(Visiter.table, visiter.toDatabaseJson(),where: "numMus = ? AND jour = ? ",whereArgs: [visiter.numMus,visiter.jour]);
  }
  void del(String numMus, DateTime jour) async{
    final Database? db = await database;
    await  db!.delete(Visiter.table,where: "numMus = ? AND jour = ? ",whereArgs: [numMus,jour]);
  }
  Future<List<Visiter>> findAll() async {
    final Database? db = await database;
    final List<Map<String, dynamic>> map = await db!.query(Visiter.table,orderBy: "jour desc,numMus desc");
    List<Visiter> visiters = List.generate(map.length, (i) {
      return Visiter.fromDatabaseJson(map[i]);
    });
    return visiters;
  }
}