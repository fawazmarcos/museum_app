import 'dart:async';
import 'package:musee/DataBase/VisiterDataBase.dart';
import 'package:musee/Model/Visiter.dart';

class VisiterDao {
  final dbProvider = VisiterDataBase.instance;
  final todoTABLE = 'visiter';

  //Adds new Visiter records
  Future<int> createVisiter(Visiter visiter) async {
    final db = await dbProvider.database;
    var result = db!.insert(todoTABLE, visiter.toDatabaseJson());
    return result;
  }

  //Get All Visiter items
  //Searches if musee int and moment date was passed
  Future<List<Visiter>> getVisiters({List<String>? columns, int? musee,DateTime? moment}) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> result;
    if (musee != null) {
        result = await db!.query(todoTABLE,
            where: 'numMus = ? and jour = ?',
            columns: columns,
            whereArgs: [musee,moment]);
    } else {
      result = await db!.query(todoTABLE, columns: columns);
    }

    List<Visiter> visiters = result.isNotEmpty
        ? result.map((item) => Visiter.fromDatabaseJson(item)).toList()
        : [ Visiter(numMus: 1,jour: DateTime(2021,12,06),nbvisiteurs: 10),
      Visiter(numMus: 2,jour: DateTime(2021,12,16), nbvisiteurs: 20 ),
      Visiter(numMus: 3,jour: DateTime(2022,01,02), nbvisiteurs: 15),
      Visiter(numMus: 4,jour: DateTime(2022,01,05), nbvisiteurs: 5),];
    return visiters;
  }

  //Update Visiter record
  Future<int> updateVisiter(Visiter visiter) async {
    final db = await dbProvider.database;

    var result = await db!.update(todoTABLE, visiter.toDatabaseJson(),
        where: 'numMus = ? and jour = ?', whereArgs: [visiter.numMus,visiter.jour]);

    return result;
  }

  //Delete Visiter records
  Future<int> deleteVisiter({int? numMus, DateTime? jour}) async {
    final db = await dbProvider.database;
    var result = await db!.delete(todoTABLE, where: 'numMus = ? and jour = ?', whereArgs: [numMus,jour]);

    return result;
  }

  //We are not going to use this in the demo
  Future deleteAllVisiters() async {
    final db = await dbProvider.database;
    var result = await db!.delete(
      todoTABLE,
    );

    return result;
  }
}
