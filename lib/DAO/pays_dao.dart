import 'dart:async';
import 'package:musee/DataBase/PaysDataBase.dart';
import 'package:musee/Model/Pays.dart';

class PaysDao {
  final dbProvider = PaysDataBase.instance;

  final todoTABLE = 'pays';
  //Adds new Pays records
  Future<int> createPays(Pays pays) async {
    final db = await dbProvider.database;
    var result = db!.insert(todoTABLE, pays.toDatabaseJson());
    return result;
  }

  //Get All Pays items
  //Searches if query string was passed
  Future<List<Pays>> getPays({List<String>? columns, String? query}) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> result;
    if (query != null && query.isNotEmpty) {
        result = await db!.query(todoTABLE,
            columns: columns,
            where: 'codePays LIKE ?',
            whereArgs: ["%$query%"]);
    } else {
      result = await db!.query(todoTABLE, columns: columns);
    }

    List<Pays> payss = result.isNotEmpty
        ? result.map((item) => Pays.fromDatabaseJson(item)).toList()
        : [ Pays(nbHabitant: 1,codePays: "Bj",),
      Pays(nbHabitant: 2,codePays: "Tg", ),
      Pays(nbHabitant: 3,codePays: "BF",),
      Pays(nbHabitant: 4,codePays: "CI",),];
    return payss;
  }

  //Update Pays record
  Future<int> updatePays(Pays pays) async {
    final db = await dbProvider.database;

    var result = await db!.update(todoTABLE, pays.toDatabaseJson(),
        where: "codePays = ?", whereArgs: [pays.codePays]);

    return result;
  }

  //Delete Pays records
  Future<int> deletePays(String codePays) async {
    final db = await dbProvider.database;
    var result = await db!.delete(todoTABLE, where: 'codePays = ?', whereArgs: [codePays]);

    return result;
  }

  //We are not going to use this in the demo
  Future deleteAllPayss() async {
    final db = await dbProvider.database;
    var result = await db!.delete(
      todoTABLE,
    );

    return result;
  }
}
