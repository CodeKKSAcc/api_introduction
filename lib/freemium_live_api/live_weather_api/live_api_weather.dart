import 'package:http/http.dart' as myHttp;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_6/freemium_live_api/live_weather_api/live_weather_api_model/live_weather_api_model.dart';

class LiveApiWeather extends StatefulWidget {
  @override
  State<LiveApiWeather> createState() => _LiveApiWeatherState();
}

class _LiveApiWeatherState extends State<LiveApiWeather> {
  String city = "Bihpuria";

  TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Every News Live API"),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: EdgeInsets.only(right: 15, top: 27, left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: cityController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                ),
                hintText: "Enter your city name...",
                suffixIcon: IconButton(
                  onPressed: () {
                    city = cityController.text.isNotEmpty
                        ? cityController.text
                        : "bihpuria";
                    setState(() {});
                  },
                  icon: Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(height: 18),
            FutureBuilder<LiveWeatherApiModel>(
              future: getLiveApi(),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(color: Colors.blue),
                  );
                } else if (snap.hasError) {
                  return Center(
                    child: Text(
                      snap.error.toString(),
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                } else if (snap.hasData) {
                  print(snap.data.toString());
                  LiveWeatherApiModel allData = snap.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        allData.name,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 21),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${allData.main.temp} C",
                            style: TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "o",
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        allData.weather[0].description,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 24,),
                      Text("Min: ${allData.main.temp_min}/ Max: ${allData.main.temp_max}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),

                    ],
                  );
                }

                return Center(
                  child: Text(
                    "Something went wrong",
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<LiveWeatherApiModel> getLiveApi() async {
    String url =
        "https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=37d39552545fa73f28c80ef909d21eea&units=metric";
    myHttp.Response getResp = await myHttp.get(Uri.parse(url));

    if (getResp.statusCode == 200) {
      dynamic data = jsonDecode(getResp.body);
      return LiveWeatherApiModel.fromJson(data);
    } else {
      throw Exception("Exception code: ${getResp.statusCode}");
    }
  }
}

// Live api from Current weather API using lat and long
// https://api.openweathermap.org/data/2.5/weather?lat=27.010808&lon=93.913181&appid=37d39552545fa73f28c80ef909d21eea&units=metric

// Live api from Current weather API using city name
// https://api.openweathermap.org/data/2.5/weather?q=bihpuria&appid=37d39552545fa73f28c80ef909d21eea&units=metric
