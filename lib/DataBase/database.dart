import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:musee/Model/Bibliotheque.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../Model/Moment.dart';
import '../Model/Musee.dart';
import '../Model/Ouvrage.dart';
import '../Model/Pays.dart';
import '../Model/Visiter.dart';

class DatabaseProvider {
  static DatabaseProvider dbProvider = DatabaseProvider();
  static  Database? _database ;
  //This is optional, and only used for changing DB schema migrations
  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }
  Future<Database?> get database async{
    if(_database != null) return _database;
    WidgetsFlutterBinding.ensureInitialized();
    _database = await initDB();
    return _database;
  }

  initDB() async{
    WidgetsFlutterBinding.ensureInitialized();

    // Open the database and store the reference.
    return await  openDatabase(join(await getDatabasesPath(),'musee.db'),
        onCreate: (db, version) async{
          await db.execute(sqlCreatePays());
          await db.execute(sqlCreateMoment());
          await db.execute(sqlCreateMusee());
          await db.execute(sqlCreateOuvrage());
          await db.execute(sqlCreateVisiter());
          await db.execute(sqlCreateBibliotheque());
          await initialData(db);
          print("====== Base de données initialisé =======");

        },
        version: 1,
        onUpgrade: onUpgrade
    );
  }

  Future<void> initialData(Database db) async {
    List<Pays> pays = [
      Pays(codePays: "bj", nbHabitant: 12123200),
      Pays(codePays: "bf", nbHabitant: 15450245),
      Pays(codePays: "ci", nbHabitant: 450896500),
      Pays(codePays: "cn", nbHabitant: 1439323776),
      Pays(codePays: "de", nbHabitant: 83783942),
      Pays(codePays: "gh", nbHabitant: 31072940),
      Pays(codePays: "ke", nbHabitant: 53771296),
      Pays(codePays: "ng", nbHabitant: 206139589),
      Pays(codePays: "ru", nbHabitant: 145934462),
      Pays(codePays: "tg", nbHabitant: 8278724),
      Pays(codePays: "us", nbHabitant: 331002651),
      Pays(codePays: "za", nbHabitant: 59308690),
    ];

    List<Moment> moments = [
      Moment(jour: DateTime(2021,12,06)),
      Moment(jour: DateTime(2021,12,08)),
      Moment(jour: DateTime(2022,01,03)),
      Moment(jour: DateTime(2022,01,05)),
    ];

    List<Musee> musees = [
      Musee(numMus: 1, nomMus: "Musée de l'UNESCO", nblivres: 560, codePays: "ke"),
      Musee(numMus: 2, nomMus: "United State of America Musée", nblivres: 36000, codePays: "us"),
      Musee(numMus: 3,nomMus: "Temple des Python",codePays: "bj",nblivres: 1000),
      Musee(numMus: 4,nomMus: "Musée de Pendjarie", nblivres: 2350,codePays: "tg" ),
      Musee(numMus: 5,nomMus: "Musée de Marina", nblivres: 1225,codePays: "bf"),
      Musee(numMus: 6,nomMus: "Porte du non retour", nblivres: 805,codePays: "ci"),
    ];

    List<Ouvrage> ouvrages = [
      Ouvrage(ISBN: '1',titre: "Python",codePays: "Bj",nbPage: 100),
      Ouvrage(ISBN: '2',codePays: "Tg",titre: "Pendjarie", nbPage: 150 ),
      Ouvrage(ISBN: '3',codePays: "BF",titre: "Marina", nbPage: 125),
      Ouvrage(ISBN: '4',codePays: "CI",titre: "Place du non retour", nbPage: 510),
    ];

    List<Bibliotheque> bibliotheques =  [
      Bibliotheque(numMus: 1,dateAchat: DateTime(2020,12,06),ISBN: "1"),
      Bibliotheque(numMus: 2,dateAchat: DateTime(2019,12,16), ISBN: "2" ),
      Bibliotheque(numMus: 3,dateAchat: DateTime(2021,01,02), ISBN: "3"),
      Bibliotheque(numMus: 4,dateAchat: DateTime(2020,01,05), ISBN: "4"),
    ];

    List<Visiter> visiters = [
      Visiter(numMus: 1,jour: DateTime(2021,12,06),nbvisiteurs: 10),
      Visiter(numMus: 2,jour: DateTime(2021,12,16), nbvisiteurs: 20),
      Visiter(numMus: 3,jour: DateTime(2022,01,02), nbvisiteurs: 15),
      Visiter(numMus: 4,jour: DateTime(2022,01,05), nbvisiteurs: 5),
    ];

    // ---- Insertions -----
    // Bibliothèques
    for (var b in bibliotheques) {
      await db.insert(Bibliotheque.table, b.toDatabaseJson(),conflictAlgorithm: ConflictAlgorithm.replace);
    }

    //Moments
    for (var m in moments) {
      await db.insert(Moment.table, m.toDatabaseJson(),conflictAlgorithm: ConflictAlgorithm.replace);
    }

    // Musées
    for (var m in musees) {
      db.insert(Musee.table, m.toDatabaseJson(),conflictAlgorithm: ConflictAlgorithm.replace);
    }

    //Ouvrages
    for (var o in ouvrages) {
      await db.insert(Ouvrage.table, o.toDatabaseJson(),conflictAlgorithm: ConflictAlgorithm.replace);
    }

    //Pays
    for (var p in pays) {
      await db.insert(Pays.table, p.toDatabaseJson(),conflictAlgorithm: ConflictAlgorithm.replace);
    }

    //Visiters
    for (var v in visiters) {
      await db.insert(Visiter.table, v.toDatabaseJson(),conflictAlgorithm: ConflictAlgorithm.replace);
    }

  }
  static String sqlCreateBibliotheque() {
    return """
    CREATE TABLE ${Bibliotheque.table}(
      "numMus" INTEGER references ${Musee.table}(numMus),"
      "ISBN" TEXT references  ${Ouvrage.table}(ISBN),"
      "dateAchat DATETIME,
      PRIMARY KEY(numMus,jour))
    """;
  }

  static String sqlCreateMoment() {
    return "Create table ${Moment.table}(jour DATETIME primary key); ";
  }

  static String sqlCreateMusee() {
    return """
        Create table ${Musee.table}("
        "numMus INTEGER primary key,"
        "nomMus TEXT,"
        "nblivres INTEGER CHECK(nblivres >= 0),"
        "codePays TEXT references ${Pays.table}(codePays) );
        """;
  }

  static String sqlCreateOuvrage() {
    return """
          Create table ${Ouvrage.table}("
          "ISBN TEXT primary key,"
          "nbPage INTEGER CHECK(nbPage >= 0),"
          "titre TEXT ,"
          "codePays TEXT references ${Pays.table}(codePays) );
          """;
  }

  static String sqlCreatePays() {
    return """
    CREATE TABLE ${Pays.table}(
      "codePays"	TEXT PRIMARY KEY,
      "nbHabitant"	INTEGER DEFAULT 0 CHECK(nblivres >= 0)
    )
    """;
  }

  static String sqlCreateVisiter() {
    return """
    CREATE TABLE ${Visiter.table}(
      "numMus" INTEGER references ${Musee.table}(numMus),"
      "jour" DATETIME references ${Moment.table}(jour),"
      "nbvisiteurs INTEGER DEFAULT 0 CHECK(nbvisiteurs >= 0),
      PRIMARY KEY(numMus,jour)
    )
    """;
  }
  Future close() async{
    final db = await dbProvider.database;
    db!.close();
  }
}
