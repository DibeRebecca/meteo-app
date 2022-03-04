import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

TextStyle titre = const TextStyle (fontWeight:FontWeight.w600,fontSize:18.0,color: Color(0xffffffff));
TextStyle info = const TextStyle (fontWeight:FontWeight.w400,fontSize:18.0,color: Color(0xffffffff));

Widget InformationAdditionnelle(
String vent,String humidite,String atmosphere, String pression){

  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(18.0),
    child:Column(
      crossAxisAlignment:CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Vent",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18.0),
                ),
                SizedBox(height: 18.0),
                Text("Pression",style: titre,),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("$vent",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18.0),
                ),
                SizedBox(height: 18.0),
                Text("$pression",style: info,),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("humidite",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18.0),
                ),
                SizedBox(height: 18.0),
                Text("atmosphere",style: titre,),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("$humidite",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18.0),
                ),
                SizedBox(height: 18.0),
                Text("$atmosphere",style: info,),
              ],
            ),
          ],
        )
      ],
    )
  );
}