import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {
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
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Sugerencias que aparecen al escibir

    final suggestedList = (query.isEmpty)
        ? recentFilms
        : films
            .where((film) => film.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestedList.length,
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.movie),
        title: Text(suggestedList[index]),
        onTap: () {},
      ),
    );
  }
}
