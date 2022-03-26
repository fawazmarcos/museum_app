import 'package:musee/Repository/moment_repository.dart';
import 'package:musee/Model/Moment.dart';

import 'dart:async';

class MomentBloc {
  //Get instance of the Repository
  final _momentRepository = MomentRepository();

  //Stream controller is the 'Admin' that manages
  //the state of our stream of data like adding
  //new data, change the state of the stream
  //and broadcast it to observers/subscribers
  final _momentController = StreamController<List<Moment>>.broadcast();

  get moments => _momentController.stream;

  MomentBloc() {
    getMoments();
  }

  getMoments({DateTime? query}) async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    if(query != null) {
      _momentController.sink.add(await _momentRepository.getAllMoment(query: query));
    }
  }

  addMoment(Moment moment) async {
    await _momentRepository.insertMoment(moment);
    getMoments();
  }

  updateMoment(Moment moment) async {
    await _momentRepository.updateMoment(moment);
    getMoments();
  }

  deleteMomentById(DateTime jour) async {
    _momentRepository.deleteMomentById(jour);
    getMoments();
  }

  dispose() {
    _momentController.close();
  }
}
