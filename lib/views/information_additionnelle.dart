import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

TextStyle titre = const TextStyle (fontWeight:FontWeight.w400,fontSize:10.0,color: Color(0xffffffff));
TextStyle info = const TextStyle (fontWeight:FontWeight.w600,fontSize:18.0,color: Color(0xffffffff));

Widget InformationAdditionnelle(
String vent,String humidite,String atmosphere, String pression){
  return Container(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(
          sigmaX: 5.0,
          sigmaY: 5.0,
        ),
        child: Container(
          color: Colors.white.withOpacity(0.2),
         // width: double.infinity,
          padding: EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text('', style: titre,),
              ),
              const SizedBox(height: 8,),
              Divider(color: Colors.white,),
              const SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      Text('Vent', style: titre,),
                      const SizedBox(height: 5,),
                      Text("$vent"+" m/s SSE",style: info,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      Text('Ressentie', style: titre,),
                      const SizedBox(height: 5,),
                      Text(pression +"°C",style: info,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 22,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      Text('Pression', style: titre,),
                      const SizedBox(height: 5,),
                      Text(atmosphere +"hPa",style: info,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      Text('Humidité', style: titre,),
                      const SizedBox(height: 5,),
                      Text(humidite +"%",style: info,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )
        ),
      ),
    ),
  );
}