import 'package:filmotk/src/pages/film_detail.dart';
import 'package:flutter/material.dart';
import 'package:filmotk/src/models/film_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  final List<Film> films;

  // Constructor
  CardSwiper({@required this.films});

  @override
  Widget build(BuildContext context) {
    // Mediaquery
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 5.0),
      child: Swiper(
        itemCount: films.length,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        layout: SwiperLayout.STACK,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () => Navigator.pushNamed(context, FilmDetail.pageName,
                  arguments: films[index]),
              child: _card(context, index));
        },
        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }

  Widget _card(BuildContext context, int index) {
    films[index].uniqueId = '${films[index].id}-card';
    return Hero(
      tag: films[index].uniqueId,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: FadeInImage(
            placeholder: AssetImage('assets/img/no-image.jpg'),
            image: NetworkImage(films[index].getPosterImg()),
            fit: BoxFit.cover,
          )),
    );
  }
}
