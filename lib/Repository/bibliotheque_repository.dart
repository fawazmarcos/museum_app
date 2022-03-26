import 'package:musee/DAO/bibliotheque_dao.dart';
import 'package:musee/Model/Bibliotheque.dart';

class BibliothequeRepository {
  final bibliothequeDao = BibliothequeDao();

  Future getAllBibliotheque({ int? musee, String? ouvrage}) => bibliothequeDao.getBibliotheques(ouvrage: ouvrage, musee: musee);

  Future insertBibliotheque(Bibliotheque bibliotheque) => bibliothequeDao.createBibliotheque(bibliotheque);

  Future updateBibliotheque(Bibliotheque bibliotheque) => bibliothequeDao.updateBibliotheque(bibliotheque);

  Future deleteBibliothequeById({ int? musee, String? ouvrage}) => bibliothequeDao.deleteBibliotheque(numMus: musee, ISBN: ouvrage);

  //We are not going to use this in the demo
  Future deleteAllBibliotheques() => bibliothequeDao.deleteAllBibliotheques();
}
