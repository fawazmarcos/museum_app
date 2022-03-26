import 'package:flutter/material.dart';
import 'package:musee/Bloc/pays_bloc.dart';
import 'package:musee/Model/Musee.dart';
import 'package:musee/Screens/Pays/ListePays.dart';
import 'package:provider/provider.dart';
import '../../Bloc/musee_bloc.dart';
import '../../Bloc/ouvrage_bloc.dart';
import '../../Model/Ouvrage.dart';
import '../../Model/Pays.dart';
import '../../main.dart';
import '../Musee/ShowMusee.dart';
import '../Ouvrage/ShowOuvrage.dart';

class ShowPays extends ListePays {
  const ShowPays({Key? key, required this.pays}) : super(key: key);
  final Pays pays;
  @override
  Widget build(BuildContext context) {
    Widget show = Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text("Code du  pays: ${pays.codePays}",
                          style:
                          const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                    ),
                    Text("Nombre d'habitant: ${pays.nbHabitant.toString()}",
                        style: TextStyle(color: Colors.grey[500], fontSize: 16))
                  ],
                )),
          ],
        ));
  Widget getMuseeWidget(AsyncSnapshot<List<Musee>> snapshot) {
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
                        ShowMusee(musee: snapshot.data![index])),);
                  //.then((val)=>getPays(snapshot.data![index]));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: ListTile(
                        title: Text(
                          snapshot.data![index].numMus.toString(),
                          style: const TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(snapshot.data![index].nomMus,
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
                                      ShowMusee(
                                          musee: snapshot.data![index])),);
                              },
                            ),
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
            Text("Aucun musée n'a encore été ajouté pour le pays ${pays.codePays}",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),
            const SizedBox(height: 5,)
          ],
        ),
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  Widget getOuvrageWidget(AsyncSnapshot<List<Ouvrage>> snapshot) {
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
                        ShowOuvrage(ouvrage: snapshot.data![index])),);
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
                        subtitle: Text(snapshot.data![index].titre,
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
                                      ShowOuvrage(ouvrage: snapshot.data![index])),);
                                //.then((val)=>getPays(snapshot.data![index]));
                              },
                            ),
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
            Text("Aucun ouvrage n'a encore été ajouté pour le pays ${pays.codePays}",
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
                          child:  Text("Liste des musées du pays ${pays.codePays}",
                            style: const TextStyle(fontWeight: FontWeight.bold),)
                      ),

                    ],
                  ),
                ),
              ),

              StreamBuilder(
                  stream: MuseeBloc().getMusees(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Musee>> snapshot) {
                    return getMuseeWidget(snapshot);
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
                        child:  Text("Liste des ouvrages du pays ${pays.codePays}",
                          style: const TextStyle(fontWeight: FontWeight.bold),)
                    ),
                  ],
                ),
              ),
            ),
            StreamBuilder(
                stream: OuvrageBloc().getOuvrages(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Ouvrage>> snapshot) {
                  return getOuvrageWidget(snapshot);
                }
            ),
          ],
        ),
      ),
    );
  }
}