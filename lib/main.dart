import 'dart:ui';

import 'package:app_meteo/model/meteo_model.dart';
import 'package:app_meteo/services/meteo_api_client.dart';
import 'package:app_meteo/views/information_additionnelle.dart';
import 'package:app_meteo/views/meteo.courant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../widgets/slider_dot.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  late String bgImg;
  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }
  MeteoApiClient client=MeteoApiClient();
  Meteo? data;
  // @override
  /*void initState() {
    // TODO: implement initState
    super.initState();
    client.getCurrentWeather("Georgia");
  }*/
  Future<void> getData() async{
    data= await client.getCurrentWeather("France");
    if (data!.temp!>30){
      bgImg = 'images/sunny.jpg';
    }
    else if(data!.temp!>20){
      bgImg = 'images/rainy.jpg';
    }
    else if(data!.temp!>10){
      bgImg = 'images/cloudy.jpeg';
    }
    else{
      bgImg = 'images/sunny.jpg';
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true ,
      //backgroundColor: Color(0xFFf9f9f9),
      appBar: AppBar(
        title:Text("Application meteo"),
        elevation:0.2,
        backgroundColor: Colors.transparent ,
        leading: IconButton(
            onPressed: (){},
          icon:Icon(
          Icons.search,size:30,color:Colors.white,
      )
      ),
        actions: [
          Container(
            //margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: GestureDetector(
              onTap:()=>print('menu clique'),
              child:SvgPicture.asset('images/menu.svg', height:30, width:30, color:Colors.white
            ),
          )
          )],
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getData(),
        builder: ( context,snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return Container(
              child: Stack(
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  bgImg,
                  fit: BoxFit.fill,
                  height: double.infinity,
                  width: double.infinity,
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.black38),
                ),
                meteoCourant(Icons.wb_sunny_rounded, "${data!.temp}°C", "${data!.ville}"),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Informations additionnelles",
                  style: TextStyle(fontSize: 24.0,color: Colors.white, fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(),
                SizedBox(
                  height: 20.0,
                ),
                 Container(
                  margin: EdgeInsets.only(top: 140, left: 15),
                  child: Row(
                    children: [
                      for(int i = 0; i<5; i++)
                        if( i == _currentPage )
                          SliderDot(true)
                        else
                          SliderDot(false)
                    ],
                  ),
                ),
                InformationAdditionnelle("${data!.vent}", "${data!.humidite}", "${data!.pression}", "${data!.atmosphere}"),

              ],
            )
            );
          }
          else if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
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



