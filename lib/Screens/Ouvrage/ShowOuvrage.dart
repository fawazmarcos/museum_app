import 'package:flutter/material.dart';

import 'package:musee/Model/Bibliotheque.dart';
import 'package:musee/Model/Ouvrage.dart';

import '../../Bloc/bibliotheque_bloc.dart';
import '../../main.dart';

import '../Bibliotheque/ShowBibliotheque.dart';

class ShowOuvrage extends StatelessWidget {
  const ShowOuvrage({Key? key, required this.ouvrage}) : super(key: key);
  final Ouvrage ouvrage;

  @override
  Widget build(BuildContext context) {

    Widget getBibliothequeWidget(AsyncSnapshot<List<Bibliotheque>> snapshot) {
      if (snapshot.hasData) {
        return snapshot.data!.isNotEmpty
            ? Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data!.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext ctxt, int index) {
              return Padding(
                padding: const EdgeInsets.all(0),
                child: InkWell(
                  highlightColor: myColor,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) =>
                          ShowBibliotheque(bibliotheque: snapshot.data![index])),);
                    //.then((val)=>getPays(snapshot.data![index]));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(
                          snapshot.data![index].numMus.toString(),
                          style: const TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(snapshot.data![index].dateAchat.toString(),
                          style: const TextStyle(fontSize: 12.0),),
                        trailing: Wrap(
                          children: [
                            IconButton(icon: const Icon(
                              Icons.more_horiz,
                              size: 20,
                              color: Colors.green,
                            ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (_) =>
                                      ShowBibliotheque(bibliotheque: snapshot.data![index])),);
                                //.then((val)=>getPays(snapshot.data![index]));
                              },
                            ),
                          ],
                        ),
                      ),
                      const Divider()
                    ],
                  ),
                ),
              );
            },
          ),
        )
            : Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
              Text("Aucun musée n'a encore été associé  à un musée ${ouvrage.ISBN}",
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),
              const SizedBox(height: 5,),
            ],
          ),
        );
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    }
    return Scaffold(
      body: Row(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              height: 35,
              width: double.infinity,
              color: const Color(0xFFE6E6E6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: const EdgeInsets.only(left: 20),
                      child:  Text("Liste des Bibliothèques de l'ouvrage ${ouvrage.ISBN}",
                        style: const TextStyle(fontWeight: FontWeight.bold),)
                  ),
                ],
              ),
            ),
          ),
          StreamBuilder(
              stream: BibliothequeBloc().getBibliotheques(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Bibliotheque>> snapshot) {
                return getBibliothequeWidget(snapshot);
              }
          ),
        ],
      ),
    );
  }
}