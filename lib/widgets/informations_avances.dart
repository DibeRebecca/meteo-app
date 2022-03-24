import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

TextStyle titre = const TextStyle(
    fontWeight: FontWeight.w400, fontSize: 17.0, color: Color(0xffffffff));
TextStyle info = const TextStyle(
    fontWeight: FontWeight.w600, fontSize: 25.0, color: Color(0xffffffff));

Widget InformationAvances(String description, String long, String lat,
    String max_temp, String min_temp) {
  return Container(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(
          sigmaX: 5.0,
          sigmaY: 5.0,
        ),
        child: Container(
            color: Colors.white.withOpacity(0.2),
            //
            padding: EdgeInsets.all(18.0),
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Informations avancées',
                    style: titre,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
               const Divider(
                  color: Colors.white,
                ),
               const SizedBox(
                  height:8,
                ),
                Column( children: [
                  Text(
                    'description:',style:titre,
                  ),
                  Text(
                    description,style:info,
                  )
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'longitude',
                          style: titre,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          long,
                          style: info,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'latitude',
                          style: titre,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          lat,
                          style: info,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 22,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ' maximale',
                          style: titre,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          max_temp +"°C",
                          style: info,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ' minimale',
                          style: titre,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          min_temp+"°C",
                          style: info,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )),
      ),
    ),
  );
}
