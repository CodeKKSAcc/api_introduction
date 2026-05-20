import 'dart:math';

import 'package:http/http.dart' as myHttp;

import 'dart:convert';

import 'package:flutter/material.dart';

import 'live_api_model/live_api_model.dart';

class LiveApiNewsEverything extends StatelessWidget {
  List<ArticlesModel> allData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Every News Live API"),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: FutureBuilder<List<ArticlesModel>>(
        future: getLiveApi(),
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
                        margin: EdgeInsets.only(right: 12, left: 12, top: 12),
                        decoration: BoxDecoration(
                          color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.network(allData[index].urlToImage, height: 99, width: 99, fit: BoxFit.fill,),
                                SizedBox(width: 21,),
                                Expanded(child: Text("Title: ${allData[index].title}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis), maxLines: 2,)),
                              ],
                            ),
                            SizedBox(height: 12,),
                            Text("Author: ${allData[index].author}", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,),),
                            SizedBox(height: 15,),
                            Divider(color: Colors.black,),
                            Text(allData[index].description, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,),),
                            SizedBox(height: 12,),
                            Text(allData[index].content, style: TextStyle(fontWeight: FontWeight.bold,),),
                            SizedBox(height: 15,),
                            Row(
                              children: [
                                Text("Sources", style: TextStyle(fontWeight: FontWeight.bold,),),
                                SizedBox(width: 12,),
                                Text("Id: ${allData[index].source.id}", style: TextStyle(fontWeight: FontWeight.bold,),),
                                SizedBox(width: 21,),
                                Text("Name: ${allData[index].source.name}", style: TextStyle(fontWeight: FontWeight.bold,),),
                              ],
                            ),
                            SizedBox(height: 12,),
                            Text("URL: ${allData[index].url}", style: TextStyle(fontWeight: FontWeight.bold,),),
                          ],
                        ),
                      );
                    },
                  )
                : Center(child: Text("No News Yet !!!"));
          }

          return Center(
            child: Text(
              "Unknown Error",
              style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
    );
  }

  Future<List<ArticlesModel>> getLiveApi() async {
    String url =
        "https://newsapi.org/v2/everything?q=bitcoin&apiKey=41b30b5c73b7415cb85e9a15d42bb6b7";
    myHttp.Response getResp = await myHttp.get(Uri.parse(url));

    if (getResp.statusCode == 200) {
      dynamic data = jsonDecode(getResp.body);
      EveryNewsData everyNewsData = EveryNewsData.fromJson(data);
      return everyNewsData.articles;
    } else {
      return [];
    }
  }
}
