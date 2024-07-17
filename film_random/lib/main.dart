import 'package:flutter/material.dart';
import 'random_film_service.dart';
import 'watched_films_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final RandomFilmService filmService = RandomFilmService();
  await filmService.initializeDatabase();

  runApp(MyApp(filmService: filmService));
}

class MyApp extends StatelessWidget {
  final RandomFilmService filmService;

  MyApp({required this.filmService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Günlük Film Önerisi'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey[900],
        ),
        body: FilmScreen(filmService: filmService),
      ),
    );
  }
}

class FilmScreen extends StatefulWidget {
  final RandomFilmService filmService;

  FilmScreen({required this.filmService});

  @override
  _FilmScreenState createState() => _FilmScreenState();
}

class _FilmScreenState extends State<FilmScreen> {
  int _remainingSuggestions = 3;
  String _filmName = '';
  String _selectedCategory = 'Tümü'; // Başlangıçta 'Tümü' kategorisi seçili

  Future<void> _getRandomFilm() async {
    String filmName = await widget.filmService.getRandomFilm();
    setState(() {
      _filmName = filmName;
      _remainingSuggestions--;
    });
  }

  void _markAsWatched() {
    widget.filmService.markAsWatched(_filmName);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$_filmName izlendi olarak işaretlendi.'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _navigateToWatchedFilms() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            WatchedFilmsScreen(filmService: widget.filmService),
      ),
    );
  }

  void _onCategoryChanged(String? value) {
    setState(() {
      _selectedCategory =
          value ?? 'Tümü'; // Eğer value null ise 'Tümü' seçilsin
      // Burada isteğinize göre kategoriye göre film önerisi yapabilirsiniz
      // Örneğin: widget.filmService.getRandomFilmByCategory(_selectedCategory);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          DropdownButton<String>(
            value: _selectedCategory,
            onChanged: _onCategoryChanged,
            items: <String>[
              'Tümü',
              'Aksiyon',
              'Komedi',
              'Drama',
              'Bilim Kurgu'
            ] // Kategorileriniz buraya
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              _filmName,
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _remainingSuggestions > 0 ? _getRandomFilm : null,
            child: Text(
              _remainingSuggestions > 0
                  ? 'Öner (${_remainingSuggestions} kalan)'
                  : 'Öneri Hakkınız Tükendi',
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: _remainingSuggestions > 0
                  ? Colors.blueGrey[900]
                  : Colors.grey,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              textStyle: TextStyle(fontSize: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _markAsWatched,
            child: Text('İzledim'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueGrey[900],
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              textStyle: TextStyle(fontSize: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _navigateToWatchedFilms,
            child: Text('İzlediklerim'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueGrey[900],
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              textStyle: TextStyle(fontSize: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
