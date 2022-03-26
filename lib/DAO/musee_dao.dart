import 'dart:async';
import 'package:musee/DataBase/MuseeDataBase.dart';
import 'package:musee/Model/Musee.dart';

class MuseeDao {
  final dbProvider = MuseeDataBase.instance;
  final todoTABLE = 'musee';

  //Adds new Musee records
  Future<int> createMusee(Musee musee) async {
    final db = await dbProvider.database;
    var result = db!.insert(todoTABLE, musee.toDatabaseJson());
    return result;
  }

  //Get All Musee items
  //Searches if query string was passed
  Future<List<Musee>> getMusees({List<String>? columns, String? query, String? codePays}) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> result;
    if (query != null && query.isNotEmpty) {
        result = await db!.query(todoTABLE,
            where: 'nomMus LIKE ? and codePays = ?',
            columns: columns,
            whereArgs: ["%$query%", codePays]);
    } else {
      result = await db!.query(todoTABLE, columns: columns);
    }

    List<Musee> musees = result.isNotEmpty
        ? result.map((item) => Musee.fromDatabaseJson(item)).toList()
        : [ Musee(numMus: 1,nomMus: "Python",codePays: "Bj",nblivres: 10),
      Musee(numMus: 2,codePays: "Tg",nomMus: "Pendjarie", nblivres: 20 ),
      Musee(numMus: 3,codePays: "BF",nomMus: "Marina", nblivres: 15),
      Musee(numMus: 4,codePays: "CI",nomMus: "Place du non retour", nblivres: 5),];
    return musees;
  }

  //Update Musee record
  Future<int> updateMusee(Musee musee) async {
    final db = await dbProvider.database;

    var result = await db!.update(todoTABLE, musee.toDatabaseJson(),
        where: "numMus = ?", whereArgs: [musee.numMus]);

    return result;
  }

  //Delete Musee records
  Future<int> deleteMusee(int numMus) async {
    final db = await dbProvider.database;
    var result = await db!.delete(todoTABLE, where: 'numMus = ?', whereArgs: [numMus]);

    return result;
  }

  //We are not going to use this in the demo
  Future deleteAllMusees() async {
    final db = await dbProvider.database;
    var result = await db!.delete(
      todoTABLE,
    );

    return result;
  }
}
