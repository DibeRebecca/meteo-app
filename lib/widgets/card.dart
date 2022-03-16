import 'package:flutter/material.dart';

import 'package:app_meteo/services/meteo_api_client.dart';
import 'package:app_meteo/model/meteo_model.dart';


Widget CardWidget(String ville,MeteoApiClient client){
  return Card(
    color: Colors.amber ,

    child:FutureBuilder<Meteo>(
        future:client.getCurrentWeather(ville),
      builder: ( context,snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(width: double.infinity, height: 100,
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("$ville", style: TextStyle(fontSize: 16)),
                        SizedBox(height: 10.0,), Text(snapshot.data!.humidite.toString())]),
                  Text("", style: TextStyle(fontSize: 36),)
                ]
            ),
          );
        } else{
          return SizedBox();
        }
      }
  ),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(25.0),
  ),

  );
}


