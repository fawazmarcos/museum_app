import 'package:musee/DataBase/database.dart';
import 'package:sqflite/sqflite.dart';
import '../Model/Pays.dart';
import 'dart:async';

class PaysDataBase extends DatabaseProvider{
  static final PaysDataBase instance = PaysDataBase._();
  PaysDataBase._();

  void create(Pays pays) async{
    final Database? db = await database;
    await  db!.insert(Pays.table, pays.toDatabaseJson(),conflictAlgorithm: ConflictAlgorithm.replace);
  }
  void edit(Pays pays) async{
    final Database? db = await database;
    await  db!.update(Pays.table, pays.toDatabaseJson(),where: "codePays = ?",whereArgs: [pays.codePays]);
  }
  void del(String codePays) async{
    final Database? db = await database;
    await  db!.delete(Pays.table,where: "codePays = ?",whereArgs: [codePays]);
  }
  Future<List<Pays>> findAll() async {
    final Database? db = await database;
    final List<Map<String, dynamic>> map = await db!.query(Pays.table);
    List<Pays> pays = List.generate(map.length, (i) {
      return Pays.fromDatabaseJson(map[i]);
    });
    return pays;
  }
}