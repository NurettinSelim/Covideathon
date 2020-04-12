import 'package:flutter/material.dart';
import 'package:korona_app/semptom2.dart';
import 'package:korona_app/globals.dart' as globals;



class Semptom extends StatelessWidget {
  // This widget is the root of your application.
  Semptom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyHomePage(title: "Semptom");
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var isim = TextEditingController();
  var email = TextEditingController();
  var yas = TextEditingController();
  goToPageTwo() {
    // When the user taps the button, navigate to a named route
    // and provide the arguments as an optional parameter.
    String data = isim.text+","+email.text+","+yas.text+","+_currentItemSelected;
    Navigator.of(context).pushNamed(
      Semptom2.routeName,arguments: data
    );
    globals.isim = isim.text;
    globals.email = email.text;
    globals.yas = yas.text;
    globals.cinsiyet = _currentItemSelected;
  }

  @override
  void initState() {
    super.initState();
  }

  var cinsiyet = ["Erkek", "Kadın"];
  var _currentItemSelected = "Erkek";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Semptomlar"),
      ),
      body: Container(
        margin: EdgeInsets.only(right: 10, left: 10, top: 20),
        child: Column(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(8),
                    child: TextFormField(
                      controller: isim,
                      decoration: const InputDecoration(
                        labelText: 'İsim Soyisim',
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
                    child: TextFormField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'E-Posta Adresi',
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
                    child: TextFormField(
                      controller: yas,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Yaş',
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
                    child: DropdownButton<String>(
                      items: cinsiyet.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          _currentItemSelected = newValue;
                        });
                      },
                      value: _currentItemSelected,
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
                            onPressed: goToPageTwo)),
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
