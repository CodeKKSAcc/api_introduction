import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as myHttpPack;

class ApiTodo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("To-Do"), centerTitle: true),
      body: FutureBuilder<List<dynamic>>(
        future: getTodo(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: Colors.blue));
          }

          if (snap.hasError) {
            return Text(snap.error.toString());
          }

          if (snap.hasData) {
            List<dynamic> myTodo = snap.data ?? [];
            return myTodo.isNotEmpty
                ? ListView.builder(
              itemCount: myTodo.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                      leading: Text(myTodo[index]["id"].toString()),
                      title: Text(myTodo[index]["todo"]),
                      subtitle: Text("UserId: ${myTodo[index]["userId"]}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Task status:"),
                          Text(
                            " ${myTodo[index]["completed"] ? "Completed" : "Not-Completed"}",
                            style: TextStyle(
                              color: myTodo[index]["completed"]
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ],
                      )
                  ),
                );
              },
            )
                : Center(child: Text("No Quotes Yet !!!"));
          }

          return Center(
            child: Text("Something Wrong", style: TextStyle(fontSize: 27)),
          );
        },
      ),
    );
  }

  Future<List<dynamic>> getTodo() async {
    String myUrl = "https://dummyjson.com/todos";

    //get (+ Query Parameters) -> to fetch the data
    myHttpPack.Response getResp = await myHttpPack.get(Uri.parse(myUrl));

    if (getResp.statusCode == 200) {
      dynamic data = jsonDecode(getResp.body);
      List<dynamic> myTodo = data["todos"];
      return myTodo;
    } else {
      return [];
    }
  }
}
