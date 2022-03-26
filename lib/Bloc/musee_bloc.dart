import 'package:musee/Repository/musee_repository.dart';
import 'package:musee/Model/Musee.dart';

import 'dart:async';

class MuseeBloc {
  //Get instance of the Repository
  final _museeRepository = MuseeRepository();

  //Stream controller is the 'Admin' that manages
  //the state of our stream of data like adding
  //new data, change the state of the stream
  //and broadcast it to observers/subscribers
  final _museeController = StreamController<List<Musee>>.broadcast();

  get musees => _museeController.stream;

  MuseeBloc() {
    getMusees();
  }

  getMusees({String? query}) async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    if(query != null) {
      _museeController.sink.add(await _museeRepository.getAllMusee(query: query));
    }
  }

  addMusee(Musee musee) async {
    await _museeRepository.insertMusee(musee);
    getMusees();
  }

  updateMusee(Musee musee) async {
    await _museeRepository.updateMusee(musee);
    getMusees();
  }

  deleteMuseeById(int numMusee) async {
    _museeRepository.deleteMuseeById(numMusee);
    getMusees();
  }

  dispose() {
    _museeController.close();
  }
}
