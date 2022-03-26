class Ouvrage{
  String ISBN;
  int nbPage;
  String titre;
  String codePays;
  static String table = 'ouvrage';

  Ouvrage({required this.ISBN, required this.nbPage,required this.titre, required this.codePays});
  Map<String, dynamic> toDatabaseJson(){
    return {
      'ISBN': ISBN,
      'nbPage': nbPage,
      'titre': titre,
      'codePays': codePays,
    };
  }
  factory Ouvrage.fromDatabaseJson(Map<String, dynamic> map) => Ouvrage(
    ISBN: map['ISBN'],
    nbPage: map['nbPage'],
    titre: map['titre'],
    codePays: map['codePays'],
  );
 }