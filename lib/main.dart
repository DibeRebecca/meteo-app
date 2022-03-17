//import 'dart:convert';
import 'dart:ui';
import '../views/recherche_ville.dart';
import 'package:app_meteo/model/meteo_model.dart';
import 'package:app_meteo/services/meteo_api_client.dart';
import 'package:app_meteo/views/information_additionnelle.dart';
import 'package:app_meteo/views/meteo.courant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_svg/svg.dart';
import '../widgets/slider_dot.dart';
import '../views/villes.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key,}) : super(key: key);

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

  late String bgImg = "";
  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  MeteoApiClient client = MeteoApiClient();
  Meteo? data;
  final List<String> selectedVilles = [] ;

  List<String> getVille() {
    return selectedVilles;
  }

  void set selectedVille(List selectedVilles) {
    selectedVilles = selectedVilles;
  }
  // @override
  /*void initState() {
    // TODO: implement initState
    super.initState();
    client.getCurrentWeather("Georgia");
  }*/
  Future<void> getData() async {
    data = await client.getCurrentWeather("Ghana");
 print(data.toString());

    //selectedVilles = await SharedPreferences.getInstance().getStringList('selectedVilles');
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
        getData();
    return Scaffold(
        extendBodyBehindAppBar: true,
        //backgroundColor: Color(0xFFf9f9f9),
        appBar: AppBar(
          title: Text("Application meteo"),
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
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_)=> RechercheVille(selectedVilles: selectedVilles,
                    ))
                    );
                //Navigator.pop(context);
              },
            )
          ],
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: getData(),
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
                    padding: EdgeInsets.only(top: 120, left: 15),
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Text(selectedVilles.toString()),
                              for (int i = 0; i < 5; i++)
                                if (i == _currentPage)
                                  SliderDot(true)
                                else
                                  SliderDot(false)
                            ],
                          ),
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
                      ],
                    ),
                  ),

                  /**/
                ],
              ));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return Container();
          },
        )

        /*Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          meteoCourant(Icons.wb_sunny_rounded, "26.3", "Lome"),
          SizedBox(
            height: 20.0,
          ),
            Text(
              "Informations additionnelles",
              style: TextStyle(fontSize: 24.0,color: Color(0xdd212121), fontWeight: FontWeight.bold,
              ),
            ),
          Divider(),
          SizedBox(
            height: 20.0,
          ),
        InformationAdditionnelle("24", "2", "1014", "24.6"),

        ],
      ),*/
        );
  }
}
