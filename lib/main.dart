import 'package:flutter/material.dart';
import 'package:project_6/freemium_live_api/live_api_news_headline.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LiveApiNewsHeadline()
    );
  }
}
