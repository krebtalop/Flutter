import 'package:flutter/material.dart';
import 'random_film_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        body: FilmScreen(),
      ),
    );
  }
}

class FilmScreen extends StatefulWidget {
  @override
  _FilmScreenState createState() => _FilmScreenState();
}

class _FilmScreenState extends State<FilmScreen> {
  final RandomFilmService _filmService = RandomFilmService();
  String _filmName = 'Bugün için bir film önerisi bekleniyor';
  int _remainingSuggestions = 3;

  @override
  void initState() {
    super.initState();
  }

  void _getRandomFilm() async {
    if (_remainingSuggestions > 0) {
      String filmName = await _filmService.getRandomFilm();
      setState(() {
        _filmName = filmName;
        _remainingSuggestions--;
      });
    } else {
      setState(() {
        _filmName = 'Günlük öneri hakkınız tükendi.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blueGrey[900]!, Colors.blueGrey[800]!],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Günün Film Önerisi',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                _filmName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _remainingSuggestions > 0 ? _getRandomFilm : null,
              child: Text(_remainingSuggestions > 0
                  ? 'Öner (${_remainingSuggestions} kalan)'
                  : 'Öneri Hakkınız Tükendi'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    _remainingSuggestions > 0
                        ? Colors.blueGrey[900]!
                        : Colors.grey),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                textStyle: MaterialStateProperty.all<TextStyle>(
                    TextStyle(fontSize: 18)),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
