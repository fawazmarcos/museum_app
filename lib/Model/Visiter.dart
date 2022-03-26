class Visiter{
  int numMus;
  DateTime jour;
  int nbvisiteurs;
  static  String table = 'visiter';

  Visiter({required this.numMus, required this.jour, required this.nbvisiteurs});
  Map<String, dynamic> toDatabaseJson(){
    return {
      'numMus': numMus,
      'jour': jour,
      'nbvisiteurs': nbvisiteurs,
    };
  }
  factory Visiter.fromDatabaseJson(Map<String, dynamic> map) => Visiter(
    numMus: map['numMus'],
    jour: map['jour'],
    nbvisiteurs: map['nbvisiteurs'],
  );
 }