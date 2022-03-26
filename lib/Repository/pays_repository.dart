import 'package:musee/DAO/pays_dao.dart';
import 'package:musee/Model/Pays.dart';

class PaysRepository {
  final paysDao = PaysDao();

  Future getAllPays({ String? query}) => paysDao.getPays(query: query);

  Future insertPays(Pays pays) => paysDao.createPays(pays);

  Future updatePays(Pays pays) => paysDao.updatePays(pays);

  Future deletePaysById(String codePays) => paysDao.deletePays(codePays);

  //We are not going to use this in the demo
  Future deleteAllPayss() => paysDao.deleteAllPayss();
}
