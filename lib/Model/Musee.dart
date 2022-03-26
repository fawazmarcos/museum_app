class Musee{
  int numMus;
  String nomMus;
  int nblivres;
  String codePays;
  static String table = 'musee';
  Musee({required this.numMus,required this.nomMus, required this.nblivres, required this.codePays});
  Map<String, dynamic> toDatabaseJson(){
    return {
      'numMus': numMus,
      'nomMus': nomMus,
      'nblivres': nblivres,
      'codePays': codePays,
    };
  }
  factory Musee.fromDatabaseJson(Map<String, dynamic> map) => Musee(
    numMus: map['numMus'],
    nomMus: map['nomMus'],
    nblivres: map['nblivres'],
    codePays: map['codePays'],
  );
 }