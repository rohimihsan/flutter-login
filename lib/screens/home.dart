import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:loginboil/models/user.dart';

class MyHomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<MyHomePage> {
  var _token;
  var _uname;

  Future<void> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('access_token');
    });
  }

  Future<void> getUser() async {
    var response = await http.get(Uri.parse('url'), headers: {
      'Authorization': 'Bearer $_token',
    });

    if (response.statusCode == 200) {
      var data = User.fromJson(jsonDecode(response.body));

      setState(() {
        _uname = data.email;
      });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: new Text("Terjadi kesalahan"),
                actions: <Widget>[
                  ElevatedButton(
                    child: new Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ]);
          });
    }
  }

  void initState() {
    super.initState();
    _token = '';
    _uname = '';
    getSharedPrefs();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(title: Text('Home Screen')),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Text("Welcome $_uname"),
              ElevatedButton(onPressed: getUser, child: Text('Refresh')),
              Text("Token : $_token"),
            ],
          ),
        ),
      ),
    ));
  }
}
