
import 'package:flutter/material.dart';

import 'package:musee/Model/Bibliotheque.dart';

class ShowBibliotheque extends StatelessWidget {
  const ShowBibliotheque({Key? key, required this.bibliotheque}) : super(key: key);
  final Bibliotheque bibliotheque;

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
                        child: Text("Numéro du musée: "+bibliotheque.numMus.toString(),
                            style:
                            const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                      ),
                      Text("L'ISBN de l'ouvrage: ${bibliotheque.ISBN} ",
                          style: TextStyle(color: Colors.grey[500], fontSize: 16)),
                      Text("Date de l'achat de l'ouvrage: ${bibliotheque.dateAchat.toString()} ",
                          style: TextStyle(color: Colors.grey[500], fontSize: 16))
                    ],
                  )
              ),
            ],
          ),
        ),
    );
  }
}