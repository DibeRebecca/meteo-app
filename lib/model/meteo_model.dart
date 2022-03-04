class Meteo{
  String? ville;
  double? temp;
  double? vent;
  int? humidite;
  double? atmosphere;
  int? pression;

  Meteo({
    this.ville,this.atmosphere,this.humidite,this.vent,this.pression,this.temp
});
  Meteo.fromJson(Map<String,dynamic>json){
    ville=json["name"];
    temp=json["main"]["temp"];
    vent=json["wind"]["speed"];
    pression=json["main"]["pressure"];
    humidite=json["main"]["humidity"];
    atmosphere=json["main"]["feels_like"];

  }
}