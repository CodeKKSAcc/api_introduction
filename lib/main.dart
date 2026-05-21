
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_6/api_cart.dart';
import 'package:project_6/api_comments.dart';
import 'package:project_6/api_product.dart';
import 'package:project_6/api_quotes.dart';
import 'package:project_6/api_todo.dart';
import 'package:project_6/api_users.dart';
import 'package:project_6/freemium_live_api/live_api_news_everything.dart';
import 'package:project_6/freemium_live_api/live_api_news_headline.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LiveApiNewsHeadline(),
    );
  }
}



/*
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Widget> pages = [
    ApiQuotes(),
    ApiComments(),
    ApiCart(),
    ApiTodo(),
    ApiProduct(),
    ApiUsers(),
    LiveApiNewsHeadline(),
    LiveApiNewsEverything(),
  ];
  
  List<String> pageName = ["Quotes", "Comments", "Cart", "Todo", "Product", "Users", "Live News Headline", "Live news"];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(),
        body: GridView.builder(
          itemCount: pageName.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), itemBuilder: (context, index){
              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> pages[index]));
                },
                child: Container(
                  alignment: Alignment(0, 0),
                  margin: EdgeInsets.only(right: 15, top: 15, left: 15),
                  decoration: BoxDecoration(
                    color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(18)
                  ),
                  child: Text(pageName[index], style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                ),
              );
        })
      ),
    );
  }
}
*/
