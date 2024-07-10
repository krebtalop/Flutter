import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Benimuygulamam());
}

class Benimuygulamam extends StatefulWidget {
  @override
  State<Benimuygulamam> createState() => _BenimuygulamamState();
}

class _BenimuygulamamState extends State<Benimuygulamam> {
  Controller controller = Controller();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Align(
          alignment: Alignment.center,
          child: Text(
            "Sayaç: " + controller.count.toString(),
            style: TextStyle(fontSize: 56, color: Colors.black),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 240, 240, 180),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => setState(() {
            controller.arttir();
          }),
        ),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 120, 83, 69),
        ),
      ),
    );
  }
}

class Controller {
  int count = 0;

  arttir() {
    count++;
  }

  azalt() {
    count--;
  }
}
