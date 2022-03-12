import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget meteoCourant( double temp, String location){
  late String icone="";
  Future<void> getImage() async{

    if (temp>30){
      icone = 'images/sun.png';
    }
    else if(temp>20){
      icone = 'images/rain.png';
    }
    else if(temp>10){
      icone = 'images/cloud.png';
    }
    else{
      icone = 'images/sun.png';
    }
  }
  return Container(
    padding: EdgeInsets.all(12.0),
    margin: EdgeInsets.only(top: 80.0),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FutureBuilder(
          future: getImage(),
          builder: ( context,snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Container(

                //crossAxisAlignment: CrossAxisAlignment.center,
                  child: Image.asset(
                      icone,
                      //fit: BoxFit.fitHeight,
                    height: 60.0,
                    width: 50.0,
                    ),

              );
            }
            return Container();
          }
          ),

          /*Image.asset(
            icone,
            //fit: 10.0,
            height: 20.0,
            width: 30.0,
          ),*/
          /*Icon(
            icon,
            color: Colors.orange,
            size: 64.0,
          ),*/
          const SizedBox(
            height: 10.0,
          ),
          Text("$temp °C",
            style: const TextStyle(
              fontSize: 66.0,
              color: Colors.white,
            ),

          ),
         const SizedBox(
              height: 10.0),
          Text(
            "$location",
            style: const TextStyle(
              fontSize: 18.0,
              color: Color(0xffffffff),
            ),
          ),
        ],

    ),
  );
}