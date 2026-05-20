import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as myHttp;

import 'live_api_model/live_api_model.dart';

class LiveApiNewsHeadline extends StatefulWidget {
  @override
  State<LiveApiNewsHeadline> createState() => _LiveApiNewsHeadlineState();
}

class _LiveApiNewsHeadlineState extends State<LiveApiNewsHeadline> {
  List<ArticlesModel> allData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Headlines"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<List<ArticlesModel>>(
        future: getHeadLines(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: Colors.blue));
          }

          if (snap.hasError) {
            return Center(
              child: Text(
                snap.error.toString(),
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
            );
          }

          if (snap.hasData) {
            allData = snap.data ?? [];
            return allData.isNotEmpty
                ? ListView.builder(
              itemCount: allData.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(9),
                        margin: EdgeInsets.only(right: 12, left: 12, top: 15),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(18),
                          /*color:
                              Colors.primaries[Random().nextInt(
                                Colors.primaries.length,
                              )],*/
                        ),
                        child: Row(
                          children: [
                          CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(allData[index].urlToImage,),
                          ),
                            SizedBox(width: 15,),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(allData[index].title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis), maxLines: 3,),
                                  SizedBox(height: 12,),
                                  Text("Author: ${allData[index].author}", style: TextStyle(fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                          ]
                        )
                      );
                    },
                  )//fit: BoxFit.fill,
                : Center(
                    child: Text(
                      "No headlines found !!!",
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
          } else {
            return Center(
              child: Text(
                "Something went wrong",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
            );
          }
        },
      ),
    );
  }

  Future<List<ArticlesModel>> getHeadLines() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=41b30b5c73b7415cb85e9a15d42bb6b7";

    myHttp.Response getResp = await myHttp.get(Uri.parse(url));
    if (getResp.statusCode == 200) {
      dynamic data = jsonDecode(getResp.body);
      EveryNewsData myData = EveryNewsData.fromJson(data);
      return myData.articles;
    } else {
      return [];
    }
  }
}

// https://newsapi.org/v2/top-headlines?country=us&apiKey=41b30b5c73b7415cb85e9a15d42bb6b7
