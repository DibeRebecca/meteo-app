//import 'dart:convert';
import 'dart:ui';
import 'package:app_meteo/widgets/informations_avances.dart';
import 'package:flutter_launcher_icons/main.dart';
import '../views/recherche_ville.dart';
import 'package:app_meteo/model/meteo_model.dart';
import 'package:app_meteo/services/meteo_api_client.dart';
import 'package:app_meteo/views/information_additionnelle.dart';
import 'package:app_meteo/views/meteo.courant.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_svg/svg.dart';
import '../widgets/slider_dot.dart';
import '../views/villes.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Application meteo',
      home: PageAccueil(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        // '/recherche': (context) => const RechercheVille(selectedVille: [],),
        '/villes': (context) => const Villes(),

        // When navigating to the "/second" route, build the SecondScreen widget.
        //'/second': (context) => const SecondScreen(),
      },
    );
  }
}

class PageAccueil extends StatefulWidget {
  const PageAccueil({Key? key}) : super(key: key);

  @override
  _PageAccueilState createState() => _PageAccueilState();
}

class _PageAccueilState extends State<PageAccueil> {
  int _currentPage = 0;
  final List<String> selectedVilles = [];
  final List<int> stIndex = [];
  late String bgImg = "";
  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void setVille(List<String> tempSelectedVilles) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('villes_key', tempSelectedVilles);
    tempSelectedVilles.indexOf("Niamtougou");
    setState(() {});
    print("setVille" +
        tempSelectedVilles.toString() +
        "----" +
        tempSelectedVilles.indexOf("Niamtougou").toString());
  }

  MeteoApiClient client = MeteoApiClient();
  Meteo? data;

  void selectedVille(List selectedVilles) {
    selectedVilles = selectedVilles;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List<String> tempSelectedVilles;
    () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      tempSelectedVilles = await prefs.getStringList('villes_key')!;
      selectedVilles.addAll(tempSelectedVilles);
      stIndex[0] = await prefs.getInt('key')!;
    };
  }

  Future<void> getData(String ville) async {
    data = await client.getCurrentWeather(ville);
    print(data.toString());

    if (data!.temp! > 30) {
      bgImg = 'images/sunny.gif';
    } else if (data!.temp! > 20) {
      bgImg = 'images/rainy.gif';
    } else if (data!.temp! > 10) {
      bgImg = 'images/coudy.gif';
    } else {
      bgImg = 'images/sunny.gif';
    }
  }

  Widget build(BuildContext context) {
    int index = stIndex.isEmpty ? 0 : stIndex[0];
    print(stIndex.isEmpty ? 0 : stIndex[0]);
    if (selectedVilles.isEmpty) {
      selectedVilles.add("Niamtougou");
    }
    return Scaffold(
        extendBodyBehindAppBar: true,
        //backgroundColor: Color(0xFFf9f9f9),
        appBar: AppBar(
          title: const Text("Application meteo"),
          elevation: 0.2,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                size: 30,
                color: Colors.white,
              )),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => RechercheVille(
                            selectedVilles: selectedVilles,
                            setVille: setVille)));
                //Navigator.pop(context);
              },
            )
          ],
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height + 200,
            child: FutureBuilder(
              future: getData(selectedVilles[index]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                      child: Stack(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        bgImg,
                        fit: BoxFit.fitHeight,
                        height: double.infinity,
                        width: double.infinity,
                      ),
                      /*Container(
                      decoration: BoxDecoration(color: Colors.black38),
                    ),*/
                      Container(
                        padding: const EdgeInsets.only(
                            top: 120, left: 10, right: 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                for (int i = 0; i < selectedVilles.length; i++)
                                  TextButton(
                                    onPressed: () async {
                                      index = i;
                                      print(i);
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      await prefs.setInt('key', i);
                                      print('----------------------'+ i.toString());
                                      print('----------------------'+ index.toString());
                                      setState(() {
                                        print('-----sst---------'+i.toString());
                                      });
                                    },
                                    child: Text(selectedVilles[i] + "  "),
                                  ),
                              ],
                            ),
                            meteoCourant(double.parse(data!.temp.toString()),
                                "${data!.ville}"),
                            const Text(
                              "Informations additionnelles",
                              style: TextStyle(
                                fontSize: 24.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            InformationAdditionnelle(
                                "${data!.vent}",
                                "${data!.humidite}",
                                "${data!.pression}",
                                "${data!.atmosphere}"),
                            SizedBox(height: 20),
                            InformationAvances(
                                "${data!.description}",
                                "${data!.long}",
                                "${data!.lat}",
                                "${data!.max_temp}",
                                "${data!.min_temp}")
                          ],
                        ),
                      ),
                    ],
                  ));
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Container();
              },
            ),
          ),
        ));
  }
}
