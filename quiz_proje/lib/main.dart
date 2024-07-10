import 'package:flutter/material.dart';
import 'questions.dart'; // questions.dart dosyasını içe aktarıyoruz

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var soruNumber = 0;

  void dogruCevap() {
    setState(() {
      soruNumber++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("QUİZ"),
          centerTitle: true,
        ),
        body: 7 > soruNumber
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      Sorular.soruListesi[soruNumber],
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(height: 5),
                    TextButton(onPressed: dogruCevap, child: Text("çok kötü")),
                    TextButton(onPressed: dogruCevap, child: Text("kötü")),
                    TextButton(onPressed: dogruCevap, child: Text("orta")),
                    TextButton(onPressed: dogruCevap, child: Text("iyi")),
                    TextButton(onPressed: dogruCevap, child: Text("çok iyi")),
                  ],
                ),
              )
            : Container(
                child:
                    Text("Ankete katılım sağladığınız için teşekkür ederiz."),
                alignment: Alignment.center,
              ),
      ),
    );
  }
}
