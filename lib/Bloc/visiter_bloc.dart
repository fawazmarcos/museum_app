import 'package:musee/Repository/visiter_repository.dart';
import 'package:musee/Model/Visiter.dart';

import 'dart:async';

class VisiterBloc {
  //Get instance of the Repository
  final _visiterRepository = VisiterRepository();

  //Stream controller is the 'Admin' that manages
  //the state of our stream of data like adding
  //new data, change the state of the stream
  //and broadcast it to observers/subscribers
  final _visiterController = StreamController<List<Visiter>>.broadcast();

  get visiters => _visiterController.stream;

  VisiterBloc() {
    getVisiters();
  }

  getVisiters({int? numMus,DateTime? jour}) async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    if(numMus != null && jour != null) {
      _visiterController.sink.add(await _visiterRepository.getAllVisiter(musee: numMus, moment: jour));
    }else if(numMus!=null){
      _visiterController.sink.add(await _visiterRepository.getAllVisiter(musee: numMus));
    }
    else if(jour!=null){
      _visiterController.sink.add(await _visiterRepository.getAllVisiter(moment: jour));
    }
  }

  addVisiter(Visiter visiter) async {
    await _visiterRepository.insertVisiter(visiter);
    getVisiters();
  }

  updateVisiter(Visiter visiter) async {
    await _visiterRepository.updateVisiter(visiter);
    getVisiters();
  }

  deleteVisiterById({int? numMus, DateTime? jour}) async {
    _visiterRepository.deleteVisiterById(musee: numMus, moment: jour);
    getVisiters();
  }

  dispose() {
    _visiterController.close();
  }
}
