
import 'package:flutter/material.dart';
import 'package:musee/Model/Bibliotheque.dart';
import 'package:musee/Model/Musee.dart';
import '../../Bloc/bibliotheque_bloc.dart';
import '../../Bloc/visiter_bloc.dart';
import '../../Model/Musee.dart';
import '../../Model/Visiter.dart';
import '../../main.dart';
import '../Bibliotheque/ShowBibliotheque.dart';
import '../Visite/ShowVisiter.dart';

class ShowMusee extends StatelessWidget {
  const ShowMusee({Key? key, required this.musee}) : super(key: key);
  final Musee musee;

  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text("Numéro du musée: "+musee.numMus.toString(),
                          style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                    ),
                    Text("Nom du musée: ${musee.nomMus} ",
                        style: TextStyle(color: Colors.grey[500], fontSize: 16)),
                    Text("Code du Pays où se situe le musée: ${musee.codePays} ",
                        style: TextStyle(color: Colors.grey[500], fontSize: 16))
                  ],
                )),
          ],
        ));

    Widget getVisiterWidget(AsyncSnapshot<List<Visiter>> snapshot) {
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
                          ShowVisiter(visiter: snapshot.data![index])),);
                    //.then((val)=>getPays(snapshot.data![index]));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: ListTile(
                          title: Text(
                            snapshot.data![index].jour.toString(),
                            style: const TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(snapshot.data![index].nbvisiteurs.toString(),
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
                                        ShowVisiter(
                                            visiter: snapshot.data![index])),);
                                  //.then((val)=>getPays(snapshot.data![index]));
                                },),
                            ],
                          ),
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
              Text("Aucun visite n'a encore été ajouté pour le musée ${musee.nomMus}",
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),
              const SizedBox(height: 5,)
            ],
          ),
        );
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    }

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
                      Container(
                        child: ListTile(
                          title: Text(
                            snapshot.data![index].ISBN,
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
                                color: Colors.green
                              ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (_) =>
                                        ShowBibliotheque(bibliotheque: snapshot.data![index])),);
                                  //.then((val)=>getPays(snapshot.data![index]));
                                },),
                            ],
                          ),
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
              Text("Aucun ouvrage n'a encore été ajouté pour le musée ${musee.nomMus}",
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
      body: Container(
        child: Row(
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
                        child:  Text("Liste des visite du musée ${musee.nomMus}",
                          style: const TextStyle(fontWeight: FontWeight.bold),)
                    ),

                  ],
                ),
              ),
            ),

            StreamBuilder(
                stream: VisiterBloc().getVisiters(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Visiter>> snapshot) {
                  return getVisiterWidget(snapshot);
                }
            ),

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
                        child:  Text("Liste des Bibliothèques du musée ${musee.nomMus}",
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
      ),
    );
  }
}