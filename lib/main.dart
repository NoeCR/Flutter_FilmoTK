import 'package:flutter/material.dart';
import 'package:filmotk/src/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Filmo TK',
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: getAppRoutes(),
    );
  }
}
