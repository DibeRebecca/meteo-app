import 'package:flutter/material.dart';
import '../widgets/card.dart';
class Villes extends StatefulWidget {
  const Villes({Key? key}) : super(key: key);

  @override
  _VillesState createState() => _VillesState();
}

class _VillesState extends State<Villes> {
  //TextEditingController controller=new TextEditingController();
  String dropdownValue = 'Lomé';
  List<String> villes=['Ghana', 'Kpalimé', 'Sokodé', 'Kara','Lomé',
    'Bassar', 'Accra', 'Yaounde', 'Niamey','Niamtougou', 'Paris', 'Nice', 'Coyonou'
    ,'Yamoussoukro', 'Brussels', 'London', 'Singapore','Bordeau', 'Nantes', 'Nantes', 'United States of America'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true ,
        appBar: AppBar(
          elevation:0.2,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_sharp,size:30,color:Colors.white,
              )
          ),

        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start ,
              children: [
                Text(
                  "Villes Populaires",
                  style: TextStyle(color: Colors.black,fontSize: 10.3),
                ),



                SizedBox(height: 15.0,),
              ],



            ),
          ),
        )



    );
  }
}

