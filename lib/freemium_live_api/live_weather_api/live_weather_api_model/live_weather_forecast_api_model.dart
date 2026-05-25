

import 'live_weather_api_model.dart';

class ForecastSysModel {
  String pod;

  ForecastSysModel({required this.pod});

  factory ForecastSysModel.fromJson(Map<String, dynamic> json) {
    return ForecastSysModel(pod: json["pod"]);
  }
}

class ForecastWindModel {
  num speed;
  num deg;
  num gust;

  ForecastWindModel({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  factory ForecastWindModel.fromJson(Map<String, dynamic> json) {
    return ForecastWindModel(
      speed: json["speed"],
      deg: json["deg"],
      gust: json["gust"],
    );
  }
}

class ForecastCloudModel {
  int all;

  ForecastCloudModel({required this.all});

  factory ForecastCloudModel.fromJson(Map<String, dynamic> json) {
    return ForecastCloudModel(all: json["all"]);
  }
}

class ForecastWeatherModel {
  int id;
  String main;
  String description;
  String icon;

  ForecastWeatherModel({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory ForecastWeatherModel.fromJson(Map<String, dynamic> json) {
    return ForecastWeatherModel(
      id: json["id"],
      main: json["main"],
      description: json["description"],
      icon: json["icon"],
    );
  }
}

class ForecastMainModel {
  num temp;
  num feels_like;
  num temp_min;
  num temp_max;
  num pressure;
  num sea_level;
  num grnd_level;
  num humidity;
  num temp_kf;

  ForecastMainModel({
    required this.temp,
    required this.feels_like,
    required this.temp_min,
    required this.temp_max,
    required this.pressure,
    required this.sea_level,
    required this.grnd_level,
    required this.humidity,
    required this.temp_kf,
  });

  factory ForecastMainModel.fromJson(Map<String, dynamic> json) {
    return ForecastMainModel(
      temp: json["temp"],
      feels_like: json["feels_like"],
      temp_min: json["temp_min"],
      temp_max: json["temp_max"],
      pressure: json["pressure"],
      sea_level: json["sea_level"],
      grnd_level: json["grnd_level"],
      humidity: json["humidity"],
      temp_kf: json["temp_kf"],
    );
  }
}

class AllForecastsModel {
  num dt;
  ForecastMainModel main;
  List<ForecastWeatherModel> weather;
  ForecastCloudModel clouds;
  ForecastWindModel wind;
  num visibility;
  num pop;
  ForecastSysModel sys;
  String dt_txt;

  AllForecastsModel({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    required this.sys,
    required this.dt_txt,
  });

  factory AllForecastsModel.fromJson(Map<String, dynamic> json) {
    List<ForecastWeatherModel> weatherForecast = [];

    for (Map<String, dynamic> myMap in json["weather"]) {
      weatherForecast.add(ForecastWeatherModel.fromJson(myMap));
    }

    return AllForecastsModel(
      dt: json["dt"],
      main: ForecastMainModel.fromJson(json["main"]),
      weather: weatherForecast,
      clouds: ForecastCloudModel.fromJson(json["clouds"]),
      wind: ForecastWindModel.fromJson(json["wind"]),
      visibility: json["visibility"],
      pop: json["pop"],
      sys: ForecastSysModel.fromJson(json["sys"]),
      dt_txt: json["dt_txt"],
    );
  }
}

class ForecastCityModel {
  int id;
  String name;
  LiveWeatherCoordinates coord;
  String country;
  int population;
  num timezone;
  num sunrise;
  num sunset;

  ForecastCityModel({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });

  factory ForecastCityModel.fromJson(Map<String, dynamic> json) {
    return ForecastCityModel(
      id: json["id"],
      name: json["name"],
      coord: LiveWeatherCoordinates.formJson(json["coord"]),
      country: json["country"],
      population: json["population"],
      timezone: json["timezone"],
      sunrise: json["sunrise"],
      sunset: json["sunset"],
    );
  }
}

class LiveWeatherForecastApiModel {
  String cod;
  int message;
  int cnt;
  List<AllForecastsModel> list;
  ForecastCityModel city;

  LiveWeatherForecastApiModel({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
    required this.city,
  });

  factory LiveWeatherForecastApiModel.fromJson(Map<String, dynamic> json) {

    List<AllForecastsModel> forecasts = [];

    for(Map<String, dynamic> myMap in json["list"]){
      forecasts.add(AllForecastsModel.fromJson(myMap));
    }

    return LiveWeatherForecastApiModel(
      cod: json["cod"],
      message: json["message"],
      cnt: json["cnt"],
      list: forecasts,
      city: ForecastCityModel.fromJson(json["city"]),
    );
  }
}
