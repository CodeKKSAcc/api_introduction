

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class ApiComments extends StatelessWidget {

  List<dynamic> allData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Comments"),centerTitle: true,),
      body: FutureBuilder<List<dynamic>>(
          future: getComments(),
          builder: (context, snap){

            if(snap.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(color: Colors.blue,),);
            }

            if(snap.hasError){
              return Text(snap.error.toString());
            }

            if(snap.hasData){
              allData = snap.data ?? [];
              return allData.isNotEmpty ? ListView.builder(
                  itemCount: allData.length,
                  itemBuilder: (context, index){
                    return Card(
                        child: Container(
                            margin: EdgeInsets.only(right: 15, left: 15, top: 15),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Id: ${allData[index]["id"]}"),
                                    Text("Likes: ${allData[index]["likes"]}"),
                                    Text(allData[index]["body"]),
                                  ],
                                ),
                                SizedBox(height: 15,),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("User Id: ${allData[index]["user"]["id"]}"),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Full name: ${allData[index]["user"]["fullName"]}"),
                                        SizedBox(height: 12,),
                                        Text("Username: ${allData[index]["user"]["username"]}"),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            )
                        )
                    );
                  }) : Center(child: Text("No Quotes Yet !!!"),);
            }

            return Center(child: Text("Something Wrong", style: TextStyle(fontSize: 27),));
          }),
    );
  }

  Future<List<dynamic>> getComments() async{
    String url = "https://dummyjson.com/comments";
    http.Response myRsp = await http.get(Uri.parse(url));

    if(myRsp.statusCode == 200){
      dynamic data = jsonDecode(myRsp.body);
      List<dynamic> myQuotes = data["comments"];
      return myQuotes;
    }
    else{
      return [];
    }
  }
}
