import 'package:flutter/material.dart';
import 'package:musee/Screens/Bibliotheque/ListeBibliotheques.dart';
import 'package:musee/Screens/Musee/ListeMusees.dart';
import 'package:musee/Screens/Pays/ListePays.dart';
import 'package:musee/Screens/Visite/ListeVisites.dart';
import 'package:musee/main.dart';

import '../DataBase/database.dart';
import 'Ouvrage/ListeOuvrages.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var currentPage = DrawerSections.Accueill;
  
  @override
  void initState() {
    DatabaseProvider museeDatabase= DatabaseProvider.dbProvider;
    super.initState();
  }

  toggleDrawer() async {
    print ('eeeeee${_scaffoldKey.currentState!.isDrawerOpen}');
    if (_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openEndDrawer();
    } else {
      _scaffoldKey.currentState!.openDrawer();
    }
  }
  @override
  Widget build(BuildContext context) {
    Widget container;
    if (currentPage == DrawerSections.listePays){
      container = const ListePays();
    }else if (currentPage == DrawerSections.listeMusees){
      container = const ListeMusees();
    }else if (currentPage == DrawerSections.listeOuvrages){
      container = const ListeOuvrages();
    }else if (currentPage == DrawerSections.listeBibliotheques){
      container = const ListeBibliotheques();
    }else if (currentPage == DrawerSections.listeVisites){
      container = const ListeVisites();
    }
    else{
      container = const Center(
        child: Text("TP Musée réalisé pour le compte du Controle terminal de Flutter en M1IRT-AL."
            " Elle a été réaliser par Faiwas MARCOS@Bishop et Marie-José SANNI@WINNER-KING",
          style: TextStyle(
            color: Colors.blueAccent,
            fontSize: 16,
          ),
        ),
      );
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(backgroundColor: myColor,
          leading: Builder(
            builder: (context) => // Ensure Scaffold is in context
                IconButton(
                  icon: const Icon(
                    Icons.menu,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  }
                ),
          ),
      ),
        drawer: Drawer(
          child: Container(
            padding: const EdgeInsets.only(top: 40, left: 10),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    // Important: Remove any padding from the ListView.
                    padding: EdgeInsets.zero,
                    children: [
                      MyDrawerList(),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Column(
                        children: const [
                      Divider(),
                      Text('Réalisé par Marie-José SANNI et Faiwas MARCOS',
                      style: TextStyle(color: Colors.blueGrey),)
                        ],
                      )
                  ),
                )
              ],
            ),
          ),
        ),
        body: container,
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Accueil",
              currentPage == DrawerSections.Accueill? true : false),
          const Divider(),
          menuItem(2, "Pays",
              currentPage == DrawerSections.listePays ? true : false),
          const Divider(),
          menuItem(3, "Musées",
              currentPage == DrawerSections.listeMusees ? true : false),
          const Divider(),
          menuItem(4, "Ouvrages",
              currentPage == DrawerSections.listeOuvrages ? true : false),
          const Divider(),
          menuItem(5, "Bibliothèques",
              currentPage == DrawerSections.listeBibliotheques ? true : false),
          const Divider(),
          menuItem(6, "Visites",
              currentPage == DrawerSections.listeVisites ? true : false),
        ],
      ),
    );
  }
  Widget menuItem(int id, String title, bool selected){
    return Material(
      child: InkWell(
        onTap: (){
          toggleDrawer();
          setState(() {
            if (id == 1){
              currentPage = DrawerSections.Accueill;
            } else if (id == 2){
              currentPage = DrawerSections.listePays;
            }else if (id == 3){
              currentPage = DrawerSections.listeMusees;
            }else if (id == 4){
              currentPage = DrawerSections.listeOuvrages;
            }else if (id == 5){
              currentPage = DrawerSections.listeBibliotheques;
            }else if (id == 6){
              currentPage = DrawerSections.listeVisites;
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

enum DrawerSections{
  Accueill,
  listePays,
  listeBibliotheques,
  listeOuvrages,
  listeMusees,
  listeVisites,
}