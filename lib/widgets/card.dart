import 'package:flutter/material.dart';

import 'package:app_meteo/services/meteo_api_client.dart';
import 'package:app_meteo/model/meteo_model.dart';


TextStyle titre = const TextStyle(
    fontWeight: FontWeight.w400, fontSize: 20.0, color: Color(0xffffffff));
TextStyle info = const TextStyle(
    fontWeight: FontWeight.w600, fontSize: 25.0, color: Color(0xffffffff));
Widget CardWidget(String ville, MeteoApiClient client) {
  return Card(
    color: Colors.blue,
    elevation: 5.0,
    child: Container(
      width: double.infinity,
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: FutureBuilder<Meteo>(
          future: client.getCurrentWeather(ville),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(

                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:<Widget> [
                          Text(ville, style: info),
                          SizedBox(width: 80),
                          Text(snapshot.data!.temp.toString()+" °C", style: titre,),
                        ]
                    ),
                    const Text(
                      "",
                      style: TextStyle(fontSize: 36),
                    )
                  ]);
            } else {
              return SizedBox();
            }
          }),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
  );
}
