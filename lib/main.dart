import 'dart:ui';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(
    home: Home()
));


// Enable Hot Load
class Home extends StatefulWidget {
  Home({Key? key, this.title = ''}) : super(key: key);
  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Forfait>> futurForfaits;
  // Mock
  // forfaits = [];

  initState() {
    futurForfaits = _fetchForfaits();
    super.initState();
    // Mock
    // Iterable list = json.decode('[{"_id":"6000ff360efa3fd999621bed","destination":"Jamaïque","villeDepart":"Montreal", "hotel":{"nom":"Hotel #6","coordonnees":"...","nombreEtoiles":3,"nombreChambres":1,"caracteristiques":["Face à la plage","Miniclub"]},"dateDepart":"2021-01-01","dateRetour":"2021-01-08","dateDepartD":"2020-01-01T00:00:00.000Z","dateRetourD":"2020-01-08T00:00:00.000Z","prix":300,"rabais":0,"vedette":true,"image" : "", "da":"0000000"},{"_id":"6000ff370efa3fd999621c03","destination":"Alaska","villeDepart":"Montreal","hotel":{"nom":"Hotel #6","coordonnees":"...","nombreEtoiles":1,"nombreChambres":1,"caracteristiques":["Face à la plage","Miniclub"]},"dateDepart":"2021-01-01","dateRetour":"2021-01-08","dateDepartD":"2020-01-01T00:00:00.000Z","dateRetourD":"2020-01-08T00:00:00.000Z","prix":300,"rabais":0,"vedette":true,"image" : "", "da":"0000000"},{"_id":"6000ff380efa3fd999621c19","destination":"Japon","villeDepart":"Montreal","hotel":{"nom":"Hotel #6","coordonnees":"...","nombreEtoiles":1,"nombreChambres":1,"caracteristiques":["Face à la plage","Miniclub"]},"dateDepart":"2021-01-01","dateRetour":"2021-01-08","dateDepartD":"2020-01-01T00:00:00.000Z","dateRetourD":"2020-01-08T00:00:00.000Z","prix":300,"rabais":0,"vedette":true,"image" : "", "da":"0000000"},{"_id":"6000ff390efa3fd999621c2f","destination":"Cuba","villeDepart":"Montreal","hotel":{"nom":"Hotel #6","coordonnees":"...","nombreEtoiles":1,"nombreChambres":1,"caracteristiques":["Face à la plage","Miniclub"]},"dateDepart":"2021-01-01","dateRetour":"2021-01-08","dateDepartD":"2020-01-01T00:00:00.000Z","dateRetourD":"2020-01-08T00:00:00.000Z","prix":300,"rabais":0,"vedette":false,"image" : "", "da":"0000000"},{"_id":"6000ff3a0efa3fd999621c45","destination":"Cuba","villeDepart":"Montreal","hotel":{"nom":"Hotel #7","coordonnees":"...","nombreEtoiles":2,"nombreChambres":20,"caracteristiques":[]},"dateDepart":"2021-01-01","dateRetour":"2021-01-08","dateDepartD":"2020-01-01T00:00:00.000Z","dateRetourD":"2020-01-08T00:00:00.000Z","prix":3000,"rabais":0,"vedette":false,"image" : "", "da":"0000000"},{"_id":"6000ff3c0efa3fd999621c5b","destination":"Cuba","villeDepart":"Montreal","hotel":{"nom":"Hotel #8","coordonnees":"...","nombreEtoiles":3,"nombreChambres":300,"caracteristiques":["Face à la plage","Miniclub","..."]},"dateDepart":"2021-01-01","dateRetour":"2021-01-08","dateDepartD":"2020-01-01T00:00:00.000Z","dateRetourD":"2020-01-08T00:00:00.000Z","prix":30000,"rabais":100,"vedette":false,"image" : "", "da":"0000000"},{"_id":"6000ff3e0efa3fd999621c71","destination":"Costa Rica","villeDepart":"Québec","hotel":{"nom":"Hotel #6","coordonnees":"...","nombreEtoiles":1,"nombreChambres":1,"caracteristiques":["Face à la plage","Miniclub"]},"dateDepart":"2021-01-01","dateRetour":"2021-01-08","dateDepartD":"2020-01-01T00:00:00.000Z","dateRetourD":"2020-01-08T00:00:00.000Z","prix":300,"rabais":0,"vedette":false,"image" : "", "da":"0000000"},{"_id":"6000ff3f0efa3fd999621c87","destination":"Costa Rica","villeDepart":"Québec","hotel":{"nom":"Hotel #7","coordonnees":"...","nombreEtoiles":2,"nombreChambres":20,"caracteristiques":[]},"dateDepart":"2021-01-01","dateRetour":"2021-01-08","dateDepartD":"2020-01-01T00:00:00.000Z","dateRetourD":"2020-01-08T00:00:00.000Z","prix":3000,"rabais":0,"vedette":false,"image" : "", "da":"0000000"},{"_id":"6000ff400efa3fd999621c9d","destination":"Costa Rica","villeDepart":"Québec","hotel":{"nom":"Hotel #8","coordonnees":"...","nombreEtoiles":3,"nombreChambres":300,"caracteristiques":["Face à la plage","Miniclub","..."]},"dateDepart":"2021-01-01","dateRetour":"2021-01-08","dateDepartD":"2020-01-01T00:00:00.000Z","dateRetourD":"2020-01-08T00:00:00.000Z","prix":30000,"rabais":100,"vedette":false,"image" : "", "da":"0000000"}]');
    // forfaits = list.map((model) => Forfait.fromJson(model)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Forfait>>(
        future: futurForfaits,
        builder: (context, snapshot) {
      if (snapshot.hasData) {
        return Scaffold(
            backgroundColor: Colors.grey[900],
            appBar: AppBar(
              title: Text('FORFAITS VOYAGE',
                  style: TextStyle(
                    fontFamily: 'LexendDeca',
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[900],
                    fontSize: 15.0,
                  )),
              centerTitle: true,
              backgroundColor: Colors.grey[850],
              elevation: 2.0,

            ),
            body: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                child: Container(
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[

                        Expanded(
                          flex:1,
                          child: ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              return
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        0, 10.0, 20.0, 10.0),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Card(
                                              elevation: 2.0,
                                              child: Image.asset('/auto-crop.jpg',)
                                          ),
                                          Card(
                                            color: Colors.grey[850],
                                            elevation: 5.0,
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  10.0, 10.0, 10.0, 10.0),
                                              child: Text(snapshot.data?[index].destination ?? '',
                                                // forfaits[index].destination,
                                                style: TextStyle(
                                                  color: Colors.amber[200],
                                                  fontSize: 28.0,
                                                  letterSpacing: 2.0,
                                                ),
                                              ),
                                            ),
                                          ),

                                          Divider(
                                            height: 30.0,
                                            color: Colors.grey[800],
                                          ),
                                          Card(
                                            color: Colors.grey[850],
                                            elevation: 5.0,
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  10.0, 10.0, 10.0, 10.0),

                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                mainAxisAlignment: MainAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(snapshot.data?[index].hotel.nom ?? '',
                                                    style: TextStyle(
                                                      color: Colors.grey[300],
                                                      letterSpacing: 2.0,
                                                      height: 1.5,
                                                      fontSize: 20.0,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    snapshot.data?[index].hotel.coordonnees ?? '',
                                                    style: TextStyle(
                                                      color: Colors.grey[300],
                                                      letterSpacing: 2.0,
                                                      height: 1.5,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text('Du ',
                                                    style: TextStyle(
                                                      color: Colors.grey[300],
                                                      letterSpacing: 2.0,
                                                      height: 1.5,
                                                      fontSize: 15.0,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(snapshot.data?[index].dateDepart.toString() ?? '',
                                                    style: TextStyle(
                                                      color: Colors.grey[300],
                                                      letterSpacing: 2.0,
                                                      height: 1.5,
                                                      fontSize: 15.0,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text('Au ',
                                                    style: TextStyle(
                                                      color: Colors.grey[300],
                                                      letterSpacing: 2.0,
                                                      height: 1.5,
                                                      fontSize: 15.0,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(snapshot.data?[index].dateRetour.toString() ?? '',
                                                    style: TextStyle(
                                                      color: Colors.grey[300],
                                                      letterSpacing: 2.0,
                                                      height: 1.5,
                                                      fontSize: 15.0,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          Card(
                                            color: Colors.grey[850],
                                            elevation: 5.0,
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  10.0, 10.0, 10.0, 10.0),
                                              child: Center(
                                                child: Container(
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .center,
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .start,
                                                    children: <Widget>[
                                                      Column(
                                                        children: [
                                                            Row(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: List.generate(5, (index) {
                                                                return Icon(index - 1 <=
                                                                    (snapshot.data?[index].hotel.nombreEtoiles ?? 0)
                                                                    ? Icons.star
                                                                    : Icons.star_border,
                                                                    color: Colors
                                                                        .amber[200]
                                                                );
                                                              }),
                                                            ),
                                                          ],
                                                          ),

                                                      Column(
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets
                                                                .fromLTRB(
                                                                10.0, 0, 10.0, 0),
                                                            child: Text(
                                                              'Lorem ipsum.',
                                                              style: TextStyle(
                                                                color: Colors.grey[300],
                                                                letterSpacing: 2.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],

                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

                                          Card(
                                            color: Colors.grey[850],
                                            elevation: 5.0,
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  10.0, 10.0, 10.0, 10.0),
                                              child: Center(
                                                child: Container(
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .center,
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceEvenly,
                                                    children: <Widget>[
                                                      Column(
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment
                                                                .center,
                                                            mainAxisAlignment: MainAxisAlignment
                                                                .spaceEvenly,
                                                            children: [
                                                              Icon(Icons.monetization_on,
                                                                  color: Colors
                                                                      .amber[200]),
                                                              SizedBox(height: 10.0),

                                                              Text('Prix',
                                                                style: TextStyle(
                                                                  color: Colors
                                                                      .grey[300],
                                                                  letterSpacing: 2.0,
                                                                ),
                                                              ),
                                                              Text(snapshot.data?[index].prix.toString() ?? ''+ ' \$',
                                                                style: TextStyle(

                                                                  color: Colors
                                                                      .grey[300],
                                                                  letterSpacing: 2.0,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment
                                                            .center,
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .spaceEvenly,
                                                        children: [
                                                          Icon(Icons.payment_outlined,
                                                              color: Colors.amber[200]),
                                                          SizedBox(height: 10.0),
                                                          Text(
                                                            'Remboursable',
                                                            style: TextStyle(
                                                              color: Colors.grey[300],
                                                              letterSpacing: 2.0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),

                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment
                                                            .center,
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .spaceEvenly,
                                                        children: [
                                                          Icon(Icons.park,
                                                              color: Colors.amber[200]),
                                                          SizedBox(height: 10.0),
                                                          Text(
                                                            'Carbon neutre',
                                                            style: TextStyle(
                                                              color: Colors.grey[300],
                                                              letterSpacing: 2.0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20.0),
                                          Divider(
                                            height: 50.0,
                                            color: Colors.amber[200],
                                            thickness: 1.0,

                                          ),
                                        ]),
                                  ),
                                );
                            },
                          ),
                        ),
                      ]),
                ),

    )
        );
            } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      });
  }
  }

Future<List<Forfait>> _fetchForfaits() async {
  final response = await http.get(Uri.https('forfaits-voyages.herokuapp.com', '/api/forfaits/da/1996412', {}));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((forfait) => new Forfait.fromJson(forfait)).toList();
  } else {
    throw Exception('Erreur de chargement des forfaits');
  }
}


class Forfait {
  String id;
  String destination;
  String villeDepart;
  DateTime dateDepart;
  DateTime dateRetour;
  String image;
  int prix;
  int rabais;
  bool vedette;
  Hotel hotel;

  Forfait({required this.id, required this.destination, required this.villeDepart, required this.dateDepart, required this.dateRetour, required this.hotel,  required this.image, required this.prix, required this.rabais, required this.vedette});

  factory Forfait.fromJson(Map<String, dynamic> json) {
    return Forfait(
      id: json['_id'],
      destination: json['destination'],
      villeDepart: json['villeDepart'],
      dateDepart: DateTime.parse(json['dateDepartD']),
      dateRetour: DateTime.parse(json['dateRetourD']),
      image: json['image'],
      prix: json['prix'],
      rabais: json['rabais'],
      vedette: json['vedette'],
      hotel:Hotel.fromJson(json['hotel']),

    );
  }
}

class Hotel {
 final String nom;
 final String coordonnees;
 final int nombreEtoiles;
 final int nombreChambres;


  Hotel({required this.nom, required this.coordonnees, required this.nombreEtoiles, required this.nombreChambres});

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
        nom:json['nom'],
        coordonnees:json['coordonnees'],
        nombreEtoiles: json['nombreEtoiles'],
        nombreChambres: json['nombreChambres'],
    );
  }
}