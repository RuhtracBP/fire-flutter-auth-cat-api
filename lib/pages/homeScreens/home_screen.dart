import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fire_flutter_auth/services/authentication_services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

String stringResponse;
Map mapResponse;

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthServices>(context);

    //print(stringResponse);

    return Scaffold(
      appBar: AppBar(
        title: Text("Inicio"),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async => await loginProvider.logout(),
          )
        ],
      ),
      body: DataFromAPI(),
    );
  }
}

class Cat {
  final String fact;

  Cat(this.fact);
}

class DataFromAPI extends StatefulWidget {
  @override
  _DataFromAPIState createState() => _DataFromAPIState();
}

class _DataFromAPIState extends State<DataFromAPI> {
  Future getCatData() async {
    var url = Uri.parse('https://catfact.ninja/facts?page=1');
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    List<Cat> cats = [];

    //Map<String, dynamic> newdata = Map<String, dynamic>.from(jsonDecode(response.body));
    //print(newdata["data"]);

    for (var u in jsonData["data"]) {
      Cat cat = Cat(u["fact"]);
      cats.add(cat);
    }

    //print(cats.length);
    return cats;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: FutureBuilder(
          future: getCatData(),
          builder: (context, snapshot) {
            //print(snapshot.data);
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data[index].fact),
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}
