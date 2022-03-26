import 'dart:async';
import 'package:musee/DataBase/OuvrageDataBase.dart';
import 'package:musee/Model/Ouvrage.dart';

class OuvrageDao {
  final dbProvider = OuvrageDataBase.instance;

  //Adds new Ouvrage records
  Future<int> createOuvrage(Ouvrage ouvrage) async {
    final db = await dbProvider.database;
    var result = db!.insert(Ouvrage.table, ouvrage.toDatabaseJson());
    return result;
  }

  //Get All Ouvrage items
  //Searches if query string was passed
  Future<List<Ouvrage>> getOuvrages({List<String>? columns, String? query, String? codePays}) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> result;
    if (query != null && query.isNotEmpty) {
        result = await db!.query(Ouvrage.table,
            where: 'titre LIKE ? and codePays =?',
            columns: columns,
            whereArgs: ["%$query%",codePays]);
    } else {
      result = await db!.query(Ouvrage.table, columns: columns);
    }

    List<Ouvrage> ouvrages = result.isNotEmpty
        ? result.map((item) => Ouvrage.fromDatabaseJson(item)).toList()
        : [ Ouvrage(ISBN: '1',titre: "Python",codePays: "Bj",nbPage: 100),
      Ouvrage(ISBN: '2',codePays: "Tg",titre: "Pendjarie", nbPage: 150 ),
      Ouvrage(ISBN: '3',codePays: "BF",titre: "Marina", nbPage: 125),
      Ouvrage(ISBN: '4',codePays: "CI",titre: "Place du non retour", nbPage: 510),];
    return ouvrages;
  }

  //Update Ouvrage record
  Future<int> updateOuvrage(Ouvrage ouvrage) async {
    final db = await dbProvider.database;

    var result = await db!.update(Ouvrage.table, ouvrage.toDatabaseJson(),
        where: "ISBN = ?", whereArgs: [ouvrage.ISBN]);

    return result;
  }

  //Delete Ouvrage records
  Future<int> deleteOuvrage(String ISBN) async {
    final db = await dbProvider.database;
    var result = await db!.delete(Ouvrage.table, where: 'ISBN = ?', whereArgs: [ISBN]);

    return result;
  }

  //We are not going to use this in the demo
  Future deleteAllOuvrages() async {
    final db = await dbProvider.database;
    var result = await db!.delete(
      Ouvrage.table,
    );

    return result;
  }
}
