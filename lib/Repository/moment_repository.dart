import 'package:musee/DAO/moment_dao.dart';
import 'package:musee/Model/Moment.dart';

class MomentRepository {
  final momentDao = MomentDao();

  Future getAllMoment({ DateTime? query}) => momentDao.getMoments(query: query);

  Future insertMoment(Moment moment) => momentDao.createMoment(moment);

  Future updateMoment(Moment moment) => momentDao.updateMoment(moment);

  Future deleteMomentById(DateTime jour) => momentDao.deleteMoment(jour);

  //We are not going to use this in the demo
  Future deleteAllMoments() => momentDao.deleteAllMoments();
}
