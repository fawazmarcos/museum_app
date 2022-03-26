import 'package:musee/Repository/ouvrage_repository.dart';
import 'package:musee/Model/Ouvrage.dart';

import 'dart:async';

class OuvrageBloc {
  //Get instance of the Repository
  final _ouvrageRepository = OuvrageRepository();

  //Stream controller is the 'Admin' that manages
  //the state of our stream of data like adding
  //new data, change the state of the stream
  //and broadcast it to observers/subscribers
  final _ouvrageController = StreamController<List<Ouvrage>>.broadcast();

  get ouvrages => _ouvrageController.stream;

  OuvrageBloc() {
    getOuvrages();
  }

  getOuvrages({String? query}) async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    if(query != null) {
      _ouvrageController.sink.add(await _ouvrageRepository.getAllOuvrage(query: query));
    }
  }

  addOuvrage(Ouvrage ouvrage) async {
    await _ouvrageRepository.insertOuvrage(ouvrage);
    getOuvrages();
  }

  updateOuvrage(Ouvrage ouvrage) async {
    await _ouvrageRepository.updateOuvrage(ouvrage);
    getOuvrages();
  }

  deleteOuvrageById(String numOuvrage) async {
    _ouvrageRepository.deleteOuvrageById(numOuvrage);
    getOuvrages();
  }

  dispose() {
    _ouvrageController.close();
  }
}
