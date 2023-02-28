// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../NavigationPage.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

void main() {
  runApp(LoginPage());
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LocalStorage storage = new LocalStorage('localstorage_app');
  final _formKey = GlobalKey<FormState>();
  String? _email, _password;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            children: <Widget>[
              Container(
                height: height * 0.35,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 125, 251, 1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 75,
                      width: 75,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: <Widget>[
                          SizedBox(
                            height: 17,
                          ),
                          Icon(
                            Icons.charging_station_outlined,
                            size: 40,
                            color: Color.fromARGB(255, 18, 50, 97),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Container(
                    transform: Matrix4.translationValues(0.0, -90.0, 0.0),
                    padding: EdgeInsets.all(15.0),
                    height: 450,
                    width: double.infinity,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13.0),
                      ),
                      elevation: 3.0,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                              top: 30,
                              bottom: 10,
                            ),
                            child: Text(
                              'S P K L U',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            'Sign in your account.',
                            style: TextStyle(
                              fontFamily: 'Inter',
                            ),
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                    top: 25,
                                    right: 30,
                                    left: 30,
                                    bottom: 10,
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          10.0,
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade200,
                                        ),
                                      ),
                                      labelText: "Email",
                                      hintText: "Masukkan email",
                                      prefixIcon: Icon(Icons.email),
                                    ),
                                    validator: (value) =>
                                        !(value?.contains('@') ?? false)
                                            ? 'Masukan email yang valid'
                                            : null,
                                    onSaved: (value) => _email = value ?? '',
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    top: 8,
                                    right: 30,
                                    left: 30,
                                    bottom: 10,
                                  ),
                                  child: TextFormField(
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          10.0,
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade200,
                                        ),
                                      ),
                                      labelText: "Password",
                                      hintText: "Masukkan password",
                                      prefixIcon: Icon(Icons.lock),
                                    ),
                                    validator: (value) => value!.length < 8
                                        ? 'Password harus lebih dari 8 karakter'
                                        : null,
                                    onSaved: (value) => _password = value ?? '',
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    top: 20,
                                    right: 30,
                                    left: 30,
                                    bottom: 10,
                                  ),
                                  child: ElevatedButton(
                                    onPressed: _submit,
                                    child: Text('Login'),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(13)),
                                      minimumSize: Size(double.infinity, 50),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        final response = await http.post(
            Uri.parse("http://spklu.solusi-rnd.tech/api/login"),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({"email": _email, "password": _password}));
        var results = jsonDecode(response.body);
        print(response.body);
        if (results["success"] == true) {
          if (results["user"]["active"] == "1") {
            storage.setItem('id', results["user"]["id"]);
            storage.setItem('api_token', results["user"]["api_token"]);
            // ignore: use_build_context_synchronously
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) {
                return NavigationPage();
              }),
            );
          } else {
            showCupertinoAlertDialog(context, "Alert!",
                "Your account is not active, please contact the administrator");
          }
        } else {
          dangerAlert(context);
        }
      } catch (e) {
        print(e);
      }
    }
  }
}

dangerAlert(context) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.error,
    width: MediaQuery.of(context).size.width / 1,
    buttonsBorderRadius: const BorderRadius.all(
      Radius.circular(2),
    ),
    dismissOnTouchOutside: false,
    dismissOnBackKeyPress: true,
    headerAnimationLoop: false,
    animType: AnimType.scale,
    title: 'ALERT',
    desc: '"Your username or password is wrong. Please check again!"',
    btnCancelOnPress: () {},
  ).show();
}

void showCupertinoAlertDialog(BuildContext context, title, content) {
  // membuat button untuk menutup dialog
  Widget okButton = CupertinoDialogAction(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // membuat alert dialog
  CupertinoAlertDialog alert = CupertinoAlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [
      okButton,
    ],
  );

  // membuka dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
