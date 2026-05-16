import 'package:flutter/material.dart';
import 'package:project_6/api_quotes.dart';

import 'api_comments.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ApiQuotes()
    );
  }
}
