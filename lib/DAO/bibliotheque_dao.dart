import 'dart:async';
import 'package:musee/DataBase/BibliothequeDataBase.dart';
import 'package:musee/Model/Bibliotheque.dart';

class BibliothequeDao {
  final dbProvider = BibliothequeDataBase.instance;
  final todoTABLE = 'bibliotheque';

  //Adds new Bibliotheque records
  Future<int> createBibliotheque(Bibliotheque bibliotheque) async {
    final db = await dbProvider.database;
    var result = db!.insert(todoTABLE, bibliotheque.toDatabaseJson());
    return result;
  }

  //Get All Bibliotheque items
  //Searches if musee int and moment date was passed
  Future<List<Bibliotheque>> getBibliotheques({List<String>? columns, int? musee,String? ouvrage}) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> result;
    if (musee != null) {
        result = await db!.query(todoTABLE,
            where: 'numMus = ? and ISBN LINK ?',
            columns: columns,
            whereArgs: [musee,"%$ouvrage%"]);
    } else {
      result = await db!.query(todoTABLE, columns: columns);
    }

    List<Bibliotheque> bibliotheques = result.isNotEmpty
        ? result.map((item) => Bibliotheque.fromDatabaseJson(item)).toList()
        : [ Bibliotheque(numMus: 1,dateAchat: DateTime(2020,12,06),ISBN: "1"),
      Bibliotheque(numMus: 2,dateAchat: DateTime(2019,12,16), ISBN: "2" ),
      Bibliotheque(numMus: 3,dateAchat: DateTime(2021,01,02), ISBN: "3"),
      Bibliotheque(numMus: 4,dateAchat: DateTime(2020,01,05), ISBN: "4"),];
    return bibliotheques;
  }

  //Update Bibliotheque record
  Future<int> updateBibliotheque(Bibliotheque bibliotheque) async {
    final db = await dbProvider.database;

    var result = await db!.update(todoTABLE, bibliotheque.toDatabaseJson(),
        where: 'numMus = ? and ISBN = ?', whereArgs: [bibliotheque.numMus,bibliotheque.ISBN]);

    return result;
  }

  //Delete Bibliotheque records
  Future<int> deleteBibliotheque({int? numMus, String? ISBN}) async {
    final db = await dbProvider.database;
    var result = await db!.delete(todoTABLE, where: 'numMus = ? and ISBN = ?', whereArgs: [numMus,ISBN]);

    return result;
  }

  //We are not going to use this in the demo
  Future deleteAllBibliotheques() async {
    final db = await dbProvider.database;
    var result = await db!.delete(
      todoTABLE,
    );

    return result;
  }
}
