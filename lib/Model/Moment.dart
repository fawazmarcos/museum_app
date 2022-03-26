class Moment{
  DateTime jour;
  static String table = 'moment';
  Moment({required this.jour});
  Map<String, dynamic> toDatabaseJson(){
    return {
      'jour': jour,
    };
  }
  factory Moment.fromDatabaseJson(Map<String, dynamic> map) => Moment(
    jour: map['jour'],
  );
 }