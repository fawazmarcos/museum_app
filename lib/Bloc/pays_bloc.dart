import 'package:musee/Repository/pays_repository.dart';
import 'package:musee/Model/Pays.dart';
import 'dart:async';

class PaysBloc {
  //Get instance of the Repository
  final _paysRepository = PaysRepository();

  //Stream controller is the 'Admin' that manages
  //the state of our stream of data like adding
  //new data, change the state of the stream
  //and broadcast it to observers/subscribers
  final _paysController = StreamController<List<Pays>>.broadcast();

  get pays => _paysController.stream;

  PaysBloc() {
    getPays();
  }

  getPays({String? query}) async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    if(query != null) {
      _paysController.sink.add(await _paysRepository.getAllPays(query: query));
    }
  }

  addPays(Pays pays) async {
    await _paysRepository.insertPays(pays);
    getPays();
  }

  updatePays(Pays pays) async {
    await _paysRepository.updatePays(pays);
    getPays();
  }

  deletePaysById(String codePays) async {
    _paysRepository.deletePaysById(codePays);
    getPays();
  }

  dispose() {
    _paysController.close();
  }
}
