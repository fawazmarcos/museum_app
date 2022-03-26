import 'package:musee/DataBase/database.dart';
import 'package:sqflite/sqflite.dart';
import '../Model/Moment.dart';

class MomentDataBase extends DatabaseProvider{
  static final MomentDataBase instance = MomentDataBase._();
  MomentDataBase._();

  void create(Moment moment) async{
    final Database? db = await database;
    await  db!.insert(Moment.table, moment.toDatabaseJson(),conflictAlgorithm: ConflictAlgorithm.replace);
  }
  void edit(Moment moment) async{
    final Database? db = await database;
    await  db!.update(Moment.table, moment.toDatabaseJson(),where: "jour = ?",whereArgs: [moment.jour]);
  }
  void del(DateTime jour) async{
    final Database? db = await database;
    await  db!.delete(Moment.table,where: "jour = ?",whereArgs: [jour]);
  }
  Future<List<Moment>> findAll() async {
    final Database? db = await database;
    final List<Map<String, dynamic>> map = await db!.query(Moment.table);
    List<Moment> moments = List.generate(map.length, (i) {
      return Moment.fromDatabaseJson(map[i]);
    });
    return moments;
  }
}