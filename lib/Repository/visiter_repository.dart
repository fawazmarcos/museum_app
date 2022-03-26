import 'package:musee/DAO/visiter_dao.dart';
import 'package:musee/Model/Visiter.dart';

class VisiterRepository {
  final visiterDao = VisiterDao();

  Future getAllVisiter({ int? musee, DateTime? moment}) => visiterDao.getVisiters(moment: moment, musee: musee);

  Future insertVisiter(Visiter visiter) => visiterDao.createVisiter(visiter);

  Future updateVisiter(Visiter visiter) => visiterDao.updateVisiter(visiter);

  Future deleteVisiterById({ int? musee, DateTime? moment}) => visiterDao.deleteVisiter(numMus: musee, jour: moment);

  //We are not going to use this in the demo
  Future deleteAllVisiters() => visiterDao.deleteAllVisiters();
}
