import 'package:flutter/material.dart';
import 'package:project_6/api_product.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ApiProduct()
    );
  }
}
