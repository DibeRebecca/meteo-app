import 'package:flutter/material.dart';
import '../widgets/card.dart';
import '../views/villes.dart';
import 'package:app_meteo/services/meteo_api_client.dart';
import 'package:app_meteo/model/meteo_model.dart';

class RechercheVille extends StatefulWidget {
  const RechercheVille({Key? key}) : super(key: key);

  @override
  _RechercheVilleState createState() => _RechercheVilleState();
}

class _RechercheVilleState extends State<RechercheVille> {
  //TextEditingController controller=new TextEditingController();


MeteoApiClient client=MeteoApiClient();

  String dropdownValue = 'Lomé';
  List<String> villes=['Ghana', 'Kpalimé', 'Sokodé', 'Kara','Lomé',
  'Bassar', 'Accra', 'Yaounde', 'Niamey','Niamtougou', 'Paris', 'Nice', 'Coyonou'
  ,'Yamoussoukro', 'Brussels', 'London', 'Singapore','Bordeau', 'Nantes', 'Nantes', 'United States of America'];

  List<String> selectedVilles = [];

  @override
   build(BuildContext context) {
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

             const Text(
                "Gerer les villes",
                style: TextStyle(color: Colors.black,fontSize: 20.3,fontWeight: FontWeight.bold),
              ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children:[

                  DropdownButton<String>(
                    value: villes.firstWhere((element) => element==dropdownValue.toString()),

                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: villes.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  ElevatedButton(onPressed: (){
                    selectedVilles.contains(dropdownValue) ?
                    selectedVilles :
                    setState(() {
                      selectedVilles.add(dropdownValue) ;
                    });
                  }, child: Icon(Icons.add))
                ]

            ),
          ),


              for (String name in selectedVilles)
              CardWidget(name, client)

            ],
          ),
        ),
      )
    );
  }
}

