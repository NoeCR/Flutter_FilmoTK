import 'package:filmotk/src/pages/film_detail.dart';
import 'package:flutter/material.dart';
import 'package:filmotk/src/models/film_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Film> films;
  final _pageController =
      new PageController(initialPage: 1, viewportFraction: 0.3);

  final Function nextPage;
  MovieHorizontal({@required this.films, @required this.nextPage});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        nextPage();
      }
    });

    return Container(
      height: _screenSize.height * 0.21,
      // Se reemplaza el contructor de PageView para evitar problemas de memoria, ya que podría renderizar miles de items
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: films
            .length, // Hay que especifacar el numero de films que tiene que mostrar
        itemBuilder: (context, index) => _card(context, films[index]),
        // children: _cards(context),
      ),
    );
  }

  Widget _card(BuildContext context, Film film) {
    final card = Container(
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
    );

    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, FilmDetail.pageName, arguments: film),
      child: card,
    );
  }

  // Deprecated, reemplazado por el método _card para renderizar solo los films requeridos
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
