import 'package:musee/DAO/musee_dao.dart';
import 'package:musee/Model/Musee.dart';

class MuseeRepository {
  final museeDao = MuseeDao();

  Future getAllMusee({ String? query,String? pays}) => museeDao.getMusees(query: query, codePays: pays);

  Future insertMusee(Musee musee) => museeDao.createMusee(musee);

  Future updateMusee(Musee musee) => museeDao.updateMusee(musee);

  Future deleteMuseeById(int numMusee) => museeDao.deleteMusee(numMusee);

  //We are not going to use this in the demo
  Future deleteAllMusees() => museeDao.deleteAllMusees();
}
