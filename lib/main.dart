import 'package:flutter/material.dart';
import 'package:korona_app/semptom.dart';
import 'package:korona_app/settings.dart';
import 'package:korona_app/semptom2.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'router.dart' as router;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
        onGenerateRoute: router.generateRoute,
        );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String urlGb = "https://api.covid19api.com/summary";
  String toplamVaka = "Yükleniyor";
  String olu = "Yükleniyor";
  String iyilesen = "Yükleniyor";
  String gbtoplamVaka = "Yükleniyor";
  String gbolu = "Yükleniyor";
  String gbiyilesen = "Yükleniyor";

  @override
  void initState() {
    super.initState();
    this.getJsonData();
    this.urlOlustur("s");
  }

  urlOlustur(String durum) {
    int gun = DateTime.now().day;
    int ay = DateTime.now().month;
    String urlTr;
    if (durum == "hata") {
      gun = gun - 1;
      if (ay < 10) {
        urlTr =
            "https://api.covid19api.com/live/country/turkey/status/confirmed/date/2020-0" +
                ay.toString() +
                "-" +
                gun.toString() +
                "T00:00:00Z";
      } else {
        urlTr =
            "https://api.covid19api.com/live/country/turkey/status/confirmed/date/2020-" +
                ay.toString() +
                "-" +
                gun.toString() +
                "T00:00:00Z";
      }
    } else {
      if (ay < 10) {
        urlTr =
            "https://api.covid19api.com/live/country/turkey/status/confirmed/date/2020-0" +
                ay.toString() +
                "-" +
                gun.toString() +
                "T00:00:00Z";
      } else {
        urlTr =
            "https://api.covid19api.com/live/country/turkey/status/confirmed/date/2020-" +
                ay.toString() +
                "-" +
                gun.toString() +
                "T00:00:00Z";
      }
    }
    return urlTr;
  }

  Future<String> getJsonData() async {
    String urlTr = urlOlustur("normal");
    var response = await http.get(Uri.encodeFull(urlTr));
    var gbresponse = await http.get(Uri.encodeFull(urlGb));
    if (response.body.length < 5) {
      urlTr = urlOlustur("hata");
      print(urlTr);
      response = await http.get(Uri.encodeFull(urlTr));
    }

    print(response.body.length);
    print(urlTr);
    setState(() {
      List data = jsonDecode(response.body);
      toplamVaka = data[0]["Confirmed"].toString();
      olu = data[0]["Deaths"].toString();
      iyilesen = data[0]["Recovered"].toString();

      var gbdata = jsonDecode(gbresponse.body);
      gbtoplamVaka = gbdata["Global"]["TotalConfirmed"].toString();
      gbolu = gbdata["Global"]["TotalDeaths"].toString();
      gbiyilesen = gbdata["Global"]["TotalRecovered"].toString();
    });

    return "Succes";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: new Drawer(
        child: new ListView(children: <Widget>[
          new ListTile(
              title: new Text("Semptomlar"),
              trailing: new Icon(Icons.arrow_left),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed("/semptom");
              }),
          new ListTile(
              title: new Text("Ayarlar"),
              trailing: new Icon(Icons.settings),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed("/settings");
              }),
          new ListTile(
            title: new Text("Menüyü Kapat"),
            trailing: new Icon(Icons.close),
            onTap: () => Navigator.of(context).pop(),
          ),
        ]),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: new Container(
          margin: const EdgeInsets.only(top: 20),
          child: Column(
            children: <Widget>[
              Text("Türkiye'de son durum:"),
              Text("Toplam vaka: $toplamVaka "),
              Text("Ölen kişi sayısı: $olu "),
              Text("İyileşen kişi sayısı: $iyilesen "),
              Text("Dünya'da son durum:"),
              Text("Toplam vaka: $gbtoplamVaka "),
              Text("Ölen kişi sayısı: $gbolu "),
              Text("İyileşen kişi sayısı: $gbiyilesen "),
            ],
          ),
        ),
      ),
    );
  }
}
