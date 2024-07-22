import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'complaint_form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Buski',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ComplaintForm(),
    );
  }
}
