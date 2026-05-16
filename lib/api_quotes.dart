import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as myHttpPack;

class ApiQuotes extends StatefulWidget {

  @override
  State<ApiQuotes> createState() => _ApiQuotesState();
}

class _ApiQuotesState extends State<ApiQuotes> {
  List<dynamic> myQuotes = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(),
    );
  }

  getQuotes() async{
    String myUrl = "https://dummyjson.com/quotes";
    //get (+ Query Parameters) -> to fetch the data
    myHttpPack.Response getResp = await myHttpPack.get(Uri.parse(myUrl));

    if(getResp.statusCode == 200){
      dynamic data = jsonDecode(getResp.body);
      myQuotes = data["quotes"];
    }
    setState((){});
  }
}


/*class ApiQuotes extends StatefulWidget {

  @override
  State<ApiQuotes> createState() => _ApiQuotesState();
}

class _ApiQuotesState extends State<ApiQuotes> {
  */
/*List<dynamic> myQuotes = [];*/ /*

  @override
  void initState() {
    super.initState();
    getQuotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Quotes"),centerTitle: true,),
        body: FutureBuilder<List<dynamic>>(
            future: getQuotes(),
            builder: (context, snap){

              if(snap.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(color: Colors.blue,),);
              }

              if(snap.hasError){
                return Text(snap.error.toString());
              }

              if(snap.hasData){
                List<dynamic> myQuotes = snap.data ?? [];
                return myQuotes.isNotEmpty ? ListView.builder(
                    itemCount: myQuotes.length,
                    itemBuilder: (context, index){
                      return Card(
                        child: ListTile(
                          leading: Text(myQuotes[index]["id"].toString()),
                          title: Text(myQuotes[index]["quote"]),
                          subtitle: Text(myQuotes[index]["author"]),
                        ),
                      );
                    }) : Center(child: Text("No Quotes Yet !!!"),);
              }

              return Center(child: Text("Something Wrong", style: TextStyle(fontSize: 27),));
            })
    );
  }

  Future<List<dynamic>> getQuotes() async{

    String myUrl = "https://dummyjson.com/quotes";

    //get (+ Query Parameters) -> to fetch the data
    myHttpPack.Response getResp = await myHttpPack.get(Uri.parse(myUrl));

    if(getResp.statusCode == 200){
      dynamic data = jsonDecode(getResp.body);
      List<dynamic> myQuotes = data["quotes"];
      return myQuotes;
    }
    else{
      return [];
    }
  }
}*/
//post(+ Body Parameters) -> to add/update the data
