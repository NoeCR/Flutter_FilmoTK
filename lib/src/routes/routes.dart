import 'package:flutter/material.dart';
import 'package:filmotk/src/pages/film_detail.dart';
import 'package:filmotk/src/pages/home_page.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return <String, WidgetBuilder>{
    HomePage.pageName: (BuildContext context) => HomePage(),
    FilmDetail.pageName: (BuildContext context) => FilmDetail(),
  };
}
