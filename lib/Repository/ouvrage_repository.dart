import 'package:musee/DAO/ouvrage_dao.dart';
import 'package:musee/Model/Ouvrage.dart';

class OuvrageRepository {
  final ouvrageDao = OuvrageDao();

  Future getAllOuvrage({ String? query,String? pays}) => ouvrageDao.getOuvrages(query: query,codePays: pays);

  Future insertOuvrage(Ouvrage ouvrage) => ouvrageDao.createOuvrage(ouvrage);

  Future updateOuvrage(Ouvrage ouvrage) => ouvrageDao.updateOuvrage(ouvrage);

  Future deleteOuvrageById(String IBSN) => ouvrageDao.deleteOuvrage(IBSN);

  //We are not going to use this in the demo
  Future deleteAllOuvrages() => ouvrageDao.deleteAllOuvrages();
}
