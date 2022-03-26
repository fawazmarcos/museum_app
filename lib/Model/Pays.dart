class Pays{
  String codePays;
  int nbHabitant;
  static String table = 'pays';

  Pays({required this.codePays, required this.nbHabitant});
  Map<String, dynamic> toDatabaseJson(){
    return {
      'codePays': codePays,
      'nbHabitant': nbHabitant,
    };
  }
  factory Pays.fromDatabaseJson(Map<String, dynamic> map) => Pays(
    codePays: map['codePays'],
    nbHabitant: map['nbHabitant'],
  );
 }