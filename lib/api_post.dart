

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_6/api_models/post_model.dart';

class ApiPost extends StatelessWidget {

  List<PostModel> allData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Posts"),centerTitle: true,),
      body: FutureBuilder<List<PostModel>>(
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
                    return Container(
                      padding: EdgeInsets.all(9),
                        margin: EdgeInsets.only(right: 15, left: 15, top: 15),
                        decoration: BoxDecoration(
                          color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Id: ${allData[index].id}"),
                                Text("Likes: ${allData[index].reaction.likes}"),
                                Text("Dislikes: ${allData[index].reaction.dislikes}"),
                                Text("Tags:${allData[index].tags[0]}"),
                                Text("Tags:${allData[index].views}"),
                              ],
                            ),
                            SizedBox(height: 15,),
                            Text("Title: ${allData[index].title}"),
                            SizedBox(height: 15,),
                            Text("Body: ${allData[index].body}")
                          ],
                        )
                    );
                  }) : Center(child: Text("No Comments Yet !!!"),);
            }

            return Center(child: Text("Something Wrong", style: TextStyle(fontSize: 27),));
          }),
    );
  }

  Future<List<PostModel>> getComments() async{
    String url = "https://dummyjson.com/posts";
    http.Response myRsp = await http.get(Uri.parse(url));

    if(myRsp.statusCode == 200){
      dynamic data = jsonDecode(myRsp.body);
      DataModel allData = DataModel.fromJson(data);
      return allData.posts;
    }
    else{
      return [];
    }
  }
}
