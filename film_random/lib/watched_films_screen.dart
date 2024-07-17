import 'package:flutter/material.dart';
import 'random_film_service.dart';

class WatchedFilmsScreen extends StatelessWidget {
  final RandomFilmService filmService;

  WatchedFilmsScreen({required this.filmService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İzlediklerim'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
      ),
      body: FutureBuilder(
        future: filmService.getWatchedFilms(),
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Henüz hiç film izlenmedi.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(snapshot.data![index]),
                  leading: Icon(Icons.movie),
                );
              },
            );
          }
        },
      ),
    );
  }
}
