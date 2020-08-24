import 'package:filmotk/src/widgets/movie_horizontal.dart';
import 'package:flutter/material.dart';
import 'package:filmotk/src/services/film_service.dart';
import 'package:filmotk/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  static final pageName = '/';
  final filmService = new FilmService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('Billboard'),
          backgroundColor: Colors.indigoAccent[100],
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: () {})
          ],
        ),
        body: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [_swiperCards(), _footer(context)],
        )));
  }

  Widget _swiperCards() {
    return FutureBuilder(
      future: filmService.getInTheaters(),
      // initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) =>
          snapshot.hasData
              ? CardSwiper(films: snapshot.data)
              : Container(
                  height: 400.0,
                  child: Center(child: CircularProgressIndicator())),
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'Popular',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          FutureBuilder(
            future: filmService.getPopulars('1'),
            // initialData: [],
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) =>
                snapshot.hasData
                    ? MovieHorizontal(films: snapshot.data)
                    : CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
