class Bibliotheque{
  int numMus;
  String ISBN;
  DateTime dateAchat;
  static String table = 'bibliotheque';
  Bibliotheque({required this.numMus,required this.ISBN,required this.dateAchat});
  Map<String, dynamic> toDatabaseJson(){
    return {
      'numMus': numMus,
      'ISBN': ISBN,
      'dateAchat': dateAchat,
    };
  }
  factory Bibliotheque.fromDatabaseJson(Map<String, dynamic> map) => Bibliotheque(
    numMus: map['numMus'],
    ISBN: map['ISBN'],
    dateAchat: map['dateAchat'],
  );
 }