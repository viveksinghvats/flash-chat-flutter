import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/forgot_password.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/round_button_design.dart';
import 'package:flash_chat/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flash_chat/httpResponse.dart';
import 'dart:convert' as convert;

class LoginScreen extends StatefulWidget {
  static const String Id = 'login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool showspinner = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ModalProgressHUD(
          inAsyncCall: showspinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/rich_icon.png'),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Email/Mobile No'),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                    //Do something with the user input.
                  },
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: 'Your Password'),
                ),
                SizedBox(
                  height: 24.0,
                ),
                RoundButton(
                  color: Colors.lightBlueAccent,
                  title: 'Log In',
                  onPressed: () async {
                    var url =
                        'https://www.1klik.in/webservices/customerLogin.php';
                    var body = {'email': '9716444828', 'password': '123456'};
                    var response =
                        await HttpResponse(url).getResponseFromPost(body);
                    if (response != null) {
                      var data = convert.jsonDecode(response);
                      print(
                          'status:${data['status']} name:${data['user']['fname']} ${data['user']['lname']}');
                    } else
                      print('Provide an appropriate Link you prick');
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  child: Text(
                    'Forgot Password',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  onTap: () => Navigator.pushNamed(context, ForgotScreen.Id),
                ),
                SizedBox(height: 20),
                InkWell(
                  child: Text(
                    'New To FamilyFood?Register Now',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  onTap: () =>
                      Navigator.pushNamed(context, RegistrationScreen.Id),
                ),
                SizedBox(height: 20),
                InkWell(
                  child: Text(
                    'Skip For Now',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.greenAccent),
                  ),
                  onTap: () => Navigator.pushNamed(context, WelcomeScreen.Id),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
