import 'package:filmotk/src/models/film_model.dart';
import 'package:filmotk/src/pages/film_detail.dart';
import 'package:filmotk/src/services/film_service.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {
  String selected = '';
  final filmService = new FilmService();
  final films = [];
  final recentFilms = [
    'Siderman',
    'Captain America',
    'Batman',
    'Aquaman',
    'Ironman'
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    // Acciones del AppBar: limpiar, cancelar busqueda
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del AppBar
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Instrucción que crea los resultados a mostrar
    return Center(
      child: Container(
        height: 100.0,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Sugerencias que aparecen al escibir
    if (query.isEmpty) return Container();

    return FutureBuilder(
      future: filmService.findFilm(query),
      // initialData: [],
      builder: (context, AsyncSnapshot<List<Film>> snapshot) => snapshot.hasData
          ? ListView(
              children: snapshot.data
                  .map((film) => ListTile(
                        title: Text(film.title),
                        subtitle: Text(film.originalTitle),
                        leading: FadeInImage(
                          placeholder: AssetImage('assets/img/no-image.jpg'),
                          image: NetworkImage(film.getPosterImg()),
                          width: 50.0,
                          fit: BoxFit.contain,
                        ),
                        onTap: () {
                          close(context, null);
                          film.uniqueId = '';
                          Navigator.pushNamed(context, FilmDetail.pageName,
                              arguments: film);
                        },
                      ))
                  .toList(),
            )
          : Center(child: CircularProgressIndicator()),
    );

    // Only for training
    // final suggestedList = (query.isEmpty)
    //     ? recentFilms
    //     : films
    //         .where((film) => film.toLowerCase().startsWith(query.toLowerCase()))
    //         .toList();

    // return ListView.builder(
    //   itemCount: suggestedList.length,
    //   itemBuilder: (context, index) => ListTile(
    //     leading: Icon(Icons.movie),
    //     title: Text(suggestedList[index]),
    //     onTap: () {
    //       selected = suggestedList[index];
    //       showResults(context);
    //     },
    //   ),
    // );
  }
}
