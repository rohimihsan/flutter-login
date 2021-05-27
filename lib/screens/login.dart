import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:loginboil/models/apiError.dart';
import 'package:loginboil/models/apiauth.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  bool visible = false;

  final emailController = TextEditingController();
  final passController = TextEditingController();

  Future userLogin() async {
    setState(() {
      visible = true;
    });

    String email = emailController.text;
    String password = passController.text;

    var url = 'login_url';

    var data = {'email': email, 'password': password};

    final response = await http.post(Uri.parse(url), body: data);

    if (response.statusCode == 200) {
      setState(() {
        visible = false;
      });

      //get jwt token
      var auth = Apiauth.fromJson(jsonDecode(response.body));

      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString('access_token', auth.access_token);
      // print(auth.access_token);

      Navigator.pushNamedAndRemoveUntil(
          context, '/home', ModalRoute.withName('/home'));
    } else {
      setState(() {
        visible = false;
      });

      var err = Apierr.fromJson(jsonDecode(response.body));

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(title: new Text(err.message), actions: <Widget>[
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Column(
            children: <Widget>[
              Container(
                width: 280,
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: emailController,
                  autocorrect: true,
                  decoration: InputDecoration(hintText: 'Email'),
                ),
              ),
              Container(
                width: 280,
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: passController,
                  autocorrect: true,
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Password'),
                ),
              ),
              ElevatedButton(
                onPressed: userLogin,
                // onPressed: checkButton,
                child: Text("Login"),
              ),
              Visibility(
                visible: visible,
                child: Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: CircularProgressIndicator()),
              ),
            ],
          )),
        ));
  }
}
