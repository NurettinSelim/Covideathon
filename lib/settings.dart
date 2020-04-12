import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatelessWidget {
  // This widget is the root of your application.

  Settings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyHomePage(title: "Ayarlar");
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String wifiName = "Yok";

  var saveWifi;

  Future<String> getValueFromSharedPref() async {
    var prefs = await SharedPreferences.getInstance();
    var savedWifiName = prefs.getString("wifiName");
    print(savedWifiName);

    if (savedWifiName == "Yok") {
      saveWifi = () async {
        wifiName = await Connectivity().getWifiName();
        print(wifiName);
        prefs.setString("wifiName", wifiName);
        setState(() {
          wifiName = wifiName;
        });
      };

      return "Yok";
    }

    setState(() {
      wifiName = savedWifiName;
    });
    return savedWifiName;
  }

  Future<String> sil() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString("wifiName", "Yok");

    setState(() {
      wifiName = prefs.getString("wifiName");
    });

    return wifiName;
  }

  @override
  void initState() {
    super.initState();
    getValueFromSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ayarlar"),
      ),
      body: Container(
        margin: EdgeInsets.only(right: 10, left: 10, top: 20),
        child: Column(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  ButtonTheme(
                    minWidth: 120.0,
                    height: 60.0,
                    child: RaisedButton(
                      onPressed: saveWifi,
                      child: Text("Wi-Fi İsmini Kaydet"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text(
                      "Wi-Fi İsmi $wifiName",
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top:100),
                    child: ButtonTheme(
                      minWidth: 120.0,
                      height: 60.0,
                      child: RaisedButton(
                        onPressed: sil,
                        child: Text("sil"),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
