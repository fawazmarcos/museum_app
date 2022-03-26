import 'dart:async';
import 'package:musee/DataBase/MomentDataBase.dart';
import 'package:musee/Model/Moment.dart';

class MomentDao {
  final dbProvider = MomentDataBase.instance;
  final todoTABLE = 'moment';

  //Adds new Moment records
  Future<int> createMoment(Moment moment) async {
    final db = await dbProvider.database;
    var result = db!.insert(todoTABLE, moment.toDatabaseJson());
    return result;
  }

  //Get All Moment items
  //Searches if query string was passed
  Future<List<Moment>> getMoments({List<String>? columns, DateTime? query}) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> result;
    if (query != null && query != null) {
        result = await db!.query(todoTABLE,
            where: 'jour =  ?',
            columns: columns,
            whereArgs: [query]);
    } else {
      result = await db!.query(todoTABLE, columns: columns);
    }

    List<Moment> moments = result.isNotEmpty
        ? result.map((item) => Moment.fromDatabaseJson(item)).toList()
        : [ Moment(jour: DateTime(2021,12,06)),
      Moment(jour: DateTime(2021,12,08)),
      Moment(jour: DateTime(2022,01,03)),
      Moment(jour: DateTime(2022,01,05)),];
    return moments;
  }

  //Update Moment record
  Future<int> updateMoment(Moment moment) async {
    final db = await dbProvider.database;

    var result = await db!.update(todoTABLE, moment.toDatabaseJson(),
        where: "jour = ?", whereArgs: [moment.jour]);

    return result;
  }

  //Delete Moment records
  Future<int> deleteMoment(DateTime jour) async {
    final db = await dbProvider.database;
    var result = await db!.delete(todoTABLE, where: 'jour = ?', whereArgs: [jour]);

    return result;
  }

  //We are not going to use this in the demo
  Future deleteAllMoments() async {
    final db = await dbProvider.database;
    var result = await db!.delete(
      todoTABLE,
    );
    return result;
  }
}
