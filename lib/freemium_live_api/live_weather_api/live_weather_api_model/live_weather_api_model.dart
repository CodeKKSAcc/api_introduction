
class LiveWeatherCoordinates {
  num lon;
  num lat;

  LiveWeatherCoordinates({required this.lon, required this.lat});

  factory LiveWeatherCoordinates.formJson(Map<String, dynamic> json) {
    return LiveWeatherCoordinates(lon: json["lon"]??0, lat: json["lat"]??0);
  }
}

class LiveWeatherModel {
  int id;
  String main;
  String description;
  String icon;

  LiveWeatherModel({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory LiveWeatherModel.formJson(Map<String, dynamic> json) {
    return LiveWeatherModel(
      id: json["id"],
      main: json["main"],
      description: json["description"],
      icon: json["icon"],
    );
  }
}

class LiveMainModel {
  num temp;
  num feels_like;
  num temp_min;
  num temp_max;
  num pressure;
  num humidity;
  num sea_level;
  num grnd_level;

  LiveMainModel({
    required this.temp,
    required this.feels_like,
    required this.temp_min,
    required this.temp_max,
    required this.pressure,
    required this.humidity,
    required this.sea_level,
    required this.grnd_level,
  });

  factory LiveMainModel.fromJson(Map<String, dynamic> json) {
    return LiveMainModel(
      temp: json["temp"]??0,
      feels_like: json["feels_like"]??0,
      temp_min: json["temp_min"]??0,
      temp_max: json["temp_max"]??0,
      pressure: json["pressure"]??0,
      humidity: json["humidity"]??0,
      sea_level: json["sea_level"]??0,
      grnd_level: json["grnd_level"]??0,
    );
  }
}

class LiveWindModel {
  num speed;
  num deg;
  num gust;

  LiveWindModel({required this.speed, required this.deg, required this.gust});

  factory LiveWindModel.fromJson(Map<String, dynamic> json) {
    return LiveWindModel(
      speed: json["speed"]??0,
      deg: json["deg"]??0,
      gust: json["gust"]??0,
    );
  }
}

class LiveWeatherCloudsModel {
  num all;

  LiveWeatherCloudsModel({required this.all});

  factory LiveWeatherCloudsModel.fromJson(Map<String, dynamic> json) {
    return LiveWeatherCloudsModel(all: json["all"]);
  }
}

class LiveWeatherSystemModel {
  String country;
  num sunrise;
  num sunset;

  LiveWeatherSystemModel({
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  factory LiveWeatherSystemModel.fromJson(Map<String, dynamic> json) {
    return LiveWeatherSystemModel(
      country: json["country"],
      sunrise: json["sunrise"],
      sunset: json["sunset"],
    );
  }
}

class LiveWeatherApiModel {
  LiveWeatherCoordinates coord;
  List<LiveWeatherModel> weather;
  String base;
  LiveMainModel main;
  num visibility;
  LiveWindModel wind;
  LiveWeatherCloudsModel clouds;
  int dt;
  LiveWeatherSystemModel sys;
  int timezone;
  int id;
  String name;
  int cod;

  LiveWeatherApiModel({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  factory LiveWeatherApiModel.fromJson(Map<String, dynamic> json) {

    List<LiveWeatherModel> myWh = [];
    for(Map<String, dynamic> allWh in json["weather"]){
      myWh.add(LiveWeatherModel.formJson(allWh));
    }

    return LiveWeatherApiModel(
      coord: LiveWeatherCoordinates.formJson(json["coord"]),
      weather: myWh,
      base: json["base"],
      main: LiveMainModel.fromJson(json["main"]),
      visibility: json["visibility"],
      wind: LiveWindModel.fromJson(json["wind"]),
      clouds: LiveWeatherCloudsModel.fromJson(json["clouds"]),
      dt: json["dt"],
      sys: LiveWeatherSystemModel.fromJson(json["sys"]),
      timezone: json["timezone"],
      id: json["id"],
      name: json["name"],
      cod: json["cod"],
    );
  }
}
