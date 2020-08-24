import 'package:flutter/material.dart';
import 'package:filmotk/src/models/film_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Film> films;

  MovieHorizontal({@required this.films});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      height: _screenSize.height * 0.2,
      child: PageView(
        pageSnapping: false,
        controller: PageController(initialPage: 1, viewportFraction: 0.3),
        children: _cards(context),
      ),
    );
  }

  List<Widget> _cards(BuildContext context) {
    return films
        .map((film) => Container(
              margin: EdgeInsets.only(right: 15.0),
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: FadeInImage(
                        height: 140.0,
                        fit: BoxFit.cover,
                        placeholder: AssetImage('assets/img/no-image.jpg'),
                        image: NetworkImage(film.getPosterImg())),
                  ),
                  SizedBox(height: 3.0),
                  Text(
                    film.title,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ))
        .toList();
  }
}
