
import 'package:flutter/material.dart';

import '../../Model/Visiter.dart';

class ShowVisiter extends StatelessWidget {
  const ShowVisiter({Key? key, required this.visiter}) : super(key: key);
  final Visiter visiter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text("Numéro du musée: "+visiter.numMus.toString(),
                            style:
                            const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                      ),
                      Text("Le moment de la visite: ${visiter.jour.toString()} ",
                          style: TextStyle(color: Colors.grey[500], fontSize: 16)),
                      Text("Nombre de visites: ${visiter.nbvisiteurs.toString()} ",
                          style: TextStyle(color: Colors.grey[500], fontSize: 16))
                    ],
                  )),
            ],
          ),
      ));
  }
}