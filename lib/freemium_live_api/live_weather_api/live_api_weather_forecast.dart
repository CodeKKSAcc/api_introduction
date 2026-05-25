import 'package:http/http.dart' as myHttp;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_6/freemium_live_api/live_weather_api/live_weather_api_model/live_weather_api_model.dart';

import 'live_weather_api_model/live_weather_forecast_api_model.dart';

class LiveApiWeatherForecast extends StatefulWidget {
  @override
  State<LiveApiWeatherForecast> createState() => _LiveApiWeatherForecast();
}

class _LiveApiWeatherForecast extends State<LiveApiWeatherForecast> {
  String city = "Guwahati";

  TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Every News Live API",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.only(right: 15, top: 27, left: 15),
        child: SingleChildScrollView(
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
                          : "Guwahati";
                      setState(() {});
                    },
                    icon: Icon(Icons.search),
                  ),
                ),
              ),
              SizedBox(height: 18),
              FutureBuilder<LiveWeatherForecastApiModel>(
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
                    LiveWeatherForecastApiModel allData = snap.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          allData.city.name,
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 18),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: allData.list.length,
                            itemBuilder: (context, index){
                          return Container(
                            // height: 210,
                            width: double.infinity,
                            margin: EdgeInsets.only(bottom: 15),
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(21),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Date-Time: ${allData.list[index].dt_txt}",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Divider(),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${allData.list[index].main.temp}",
                                      style: TextStyle(
                                        fontSize: 45,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 9),
                                    Text(
                                      "o",
                                      style: TextStyle(
                                        fontSize: 21,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "C",
                                      style: TextStyle(
                                        fontSize: 45,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Text.rich(
                                  TextSpan(text: allData.list[index].weather[0].main, style: TextStyle(
                                    fontSize: 33,
                                    fontWeight: FontWeight.bold,
                                  ),
                                    children: [
                                      TextSpan(
                                        text: "(${allData.list[index].weather[0].description})",
                                        style: TextStyle(
                                          fontSize: 30,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ]
                                  )
                                ),
                                SizedBox(height: 12),
                                Text(
                                  "Min: ${allData.list[0].main.temp_min}/Max: ${allData.list[0].main.temp_max}",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  ),
                                ),
                                SizedBox(height: 12,),
                                Text("Humidity: ${allData.list[index].main.humidity}", style: TextStyle(fontSize: 21,
                                  fontWeight: FontWeight.bold,),)
                              ],
                            ),
                          );
                        })
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
      ),
    );
  }

  Future<LiveWeatherForecastApiModel> getLiveApi() async {
    String url =
        "https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=37d39552545fa73f28c80ef909d21eea&units=metric";
    myHttp.Response getResp = await myHttp.get(Uri.parse(url));

    if (getResp.statusCode == 200) {
      dynamic data = jsonDecode(getResp.body);
      LiveWeatherForecastApiModel allForecast =
          LiveWeatherForecastApiModel.fromJson(data);
      return allForecast;
    } else {
      throw Exception("Exception code: ${getResp.statusCode}");
    }
  }
}

// https://api.openweathermap.org/data/2.5/forecast?q=Guwahati&appid=37d39552545fa73f28c80ef909d21eea&units=metric
