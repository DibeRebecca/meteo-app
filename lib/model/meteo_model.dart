class Meteo{
  String? ville;
  double? temp;
  double? vent;
  int? humidite;
  double? atmosphere;
  int? pression;
  double? long;
  double? lat;
  double? min_temp;
  double? max_temp;
  String? description;



  Meteo({
    this.ville,this.atmosphere,this.humidite,this.vent,this.pression,this.temp,this.long,this.lat,this.description,this.max_temp,this.min_temp
  });
  Meteo.fromJson(Map<String,dynamic>json){
    ville=json["name"];
    temp=json["main"]["temp"];
    vent=json["wind"]["speed"];
    pression=json["main"]["pressure"];
    humidite=json["main"]["humidity"];
    atmosphere=json["main"]["feels_like"];
    lat=json["coord"]["lat"];
    long=json["coord"]["lon"];
    min_temp=json["main"]["temp_min"];
    max_temp=json["main"]["temp_max"];
    description=json["weather"][0]["description"];

  }
}