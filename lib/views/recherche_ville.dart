import 'package:flutter/material.dart';
import '../widgets/card.dart';
import '../views/villes.dart';
import 'package:app_meteo/services/meteo_api_client.dart';
import 'package:app_meteo/model/meteo_model.dart';

class RechercheVille extends StatefulWidget {
  final List<String> selectedVilles;
  final Function setVille;
  const RechercheVille({Key? key, required this.selectedVilles,required this.setVille})
      : super(key: key);

  @override
  _RechercheVilleState createState() => _RechercheVilleState();
}

class _RechercheVilleState extends State<RechercheVille> {
  //TextEditingController controller=new TextEditingController();

  MeteoApiClient client = MeteoApiClient();

  String dropdownValue = 'Lomé';
  List<String> villes = [
    'Ghana',
    'Kpalimé',
    'Sokodé',
    'Kara',
    'Lomé',
    'Bassar',
    'Accra',
    'Yaounde',
    'Niamey',
    'Niamtougou',
    'Paris',
    'Nice',
    'Cotonou',
    'Yamoussoukro',
    'Brussels',
    'London',
    'Singapore',
    'Bordeau',
    'Nantes',
    'Luxembourg',
    'United States of America'
  ];


  @override
  build(BuildContext context) {
   List<String> selectedVilles = widget.selectedVilles;

    return Scaffold(
      //extendBodyBehindAppBar: true ,
      appBar: AppBar(
        elevation: 0.2,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_sharp,
              size: 30,
              color: Colors.white,
            )),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Gerer les villes",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.3,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownButton<String>(
                      value: villes.firstWhere(
                          (element) => element == dropdownValue.toString()),
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
                      items:
                          villes.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (selectedVilles.contains(dropdownValue)) {
                            return;
                          } else {
                            setState(() {
                              selectedVilles.add(dropdownValue);
                              widget.setVille(selectedVilles);
                            });
                            print(selectedVilles.toString());
                          }
                        },
                        child: const Icon(Icons.add))
                  ]),
            ), Container(
              height: 500,
              child: ListView.builder(
                  itemCount: selectedVilles.length,
                  itemBuilder: (BuildContext context,int index){
                    return Dismissible(key: Key(selectedVilles[index]), onDismissed: (direction) {
                      // Remove the item from the data source.
                      setState(() {
                        selectedVilles.removeAt(index);
                        widget.setVille(selectedVilles);
                      });
                    },child: CardWidget(selectedVilles[index], client));
                  }
              ),
            ),


          ],
        ),
      )),
    );
  }
}
