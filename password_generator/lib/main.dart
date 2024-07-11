import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(SifreUreticisiApp());
}

class SifreUreticisiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Şifre Üreticisi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SifreUreticisiHomePage(),
    );
  }
}

class SifreUreticisiHomePage extends StatefulWidget {
  @override
  _SifreUreticisiHomePageState createState() => _SifreUreticisiHomePageState();
}

class _SifreUreticisiHomePageState extends State<SifreUreticisiHomePage> {
  String _sifre = '';

  void _sifreUret() {
    const length = 12;
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random rnd = Random();

    setState(() {
      _sifre = String.fromCharCodes(Iterable.generate(
        length,
        (_) => chars.codeUnitAt(rnd.nextInt(chars.length)),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Şifre Üreticisi'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Üretilen Şifre:',
            ),
            Text(
              _sifre,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sifreUret,
              child: Text('Şifre Üret'),
            ),
          ],
        ),
      ),
    );
  }
}
