import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:korona_app/globals.dart' as globals;

class Semptom2 extends StatelessWidget {
  // This widget is the root of your application.
  static const routeName = "/semptom2";

  final String argument;
  Semptom2({Key key, this.argument}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyHomePage(argument: argument);
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.argument}) : super(key: key);

  final String argument;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var values = globals.sorular;

  var ateskontrol = TextEditingController();
  var isim = globals.isim;
  var email = globals.email;
  var yas = globals.yas;
  var cinsiyet = globals.cinsiyet;
  
  goToPageThree() {
    int skor;
    values.forEach((k, v){
      if(v){
        skor++;
      }
    });
    
    globals.skor = skor;
    globals.ates = int.parse(ateskontrol.text);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Semptom2"), //widget.argument),
      ),
      body: Container(
        margin: EdgeInsets.only(right: 10, left: 10, top: 20),
        child: Column(
          children: <Widget>[
            new ListView(
              shrinkWrap: true,
              children: values.keys.map((String key) {
                return new CheckboxListTile(
                  title: new Text(key),
                  value: values[key],
                  onChanged: (bool value) {
                    setState(() {
                      values[key] = value;
                    });
                  },
                );
              }).toList(),
            ),
            Container(
              margin: EdgeInsets.all(8),
              child: TextFormField(
                controller: ateskontrol,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Ates',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 8,
                right: 8,
                top: 32,
              ),
              child: ButtonTheme(
                  minWidth: 120,
                  height: 40,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                  ),
                  child: RaisedButton(
                      child: Text("Diğer Sayfaya Geç"),
                      onPressed: goToPageThree)),
            ),
          ],
        ),
      ),
    );
  }
}
