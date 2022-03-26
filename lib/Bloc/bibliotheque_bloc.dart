import 'package:musee/Repository/bibliotheque_repository.dart';
import 'package:musee/Model/Bibliotheque.dart';

import 'dart:async';

class BibliothequeBloc  {
  //Get instance of the Repository
  final _bibliothequeRepository = BibliothequeRepository();

  //Stream controller is the 'Admin' that manages
  //the state of our stream of data like adding
  //new data, change the state of the stream
  //and broadcast it to observers/subscribers
  final _bibliothequeController = StreamController<List<Bibliotheque>>.broadcast();

  get bibliotheques => _bibliothequeController.stream;

  BibliothequeBloc() {
    getBibliotheques();
  }

  getBibliotheques({int? numMus,String? ISBN}) async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    if(numMus != null && ISBN != null) {
      _bibliothequeController.sink.add(await _bibliothequeRepository.getAllBibliotheque(musee: numMus, ouvrage: ISBN));
    }else if(numMus!=null){
      _bibliothequeController.sink.add(await _bibliothequeRepository.getAllBibliotheque(musee: numMus));
    }
    else if(ISBN!=null){
      _bibliothequeController.sink.add(await _bibliothequeRepository.getAllBibliotheque(ouvrage: ISBN));
    }
  }

  addBibliotheque(Bibliotheque bibliotheque) async {
    await _bibliothequeRepository.insertBibliotheque(bibliotheque);
    getBibliotheques();
  }

  updateBibliotheque(Bibliotheque bibliotheque) async {
    await _bibliothequeRepository.updateBibliotheque(bibliotheque);
    getBibliotheques();
  }

  deleteBibliothequeById({int? numMus, String? ISBN}) async {
    _bibliothequeRepository.deleteBibliothequeById(musee: numMus, ouvrage: ISBN);
    getBibliotheques();
  }

  dispose() {
    _bibliothequeController.close();
  }
}
