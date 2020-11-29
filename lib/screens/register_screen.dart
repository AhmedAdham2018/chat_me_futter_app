import 'package:chat_me/screens/home_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'register_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  //final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseAuth _auth = FirebaseAuth.instance;

  String _email;
  String _password;
  bool _showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat me'),
      ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Chat me ',
                    style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.red),
                  ),
                  Hero(
                    tag: 'logo',
                    child: Container(
                      height: 50.0,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (emailValue) {
                  //Do something with the user input.
                  _email = emailValue;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your Email',
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (passwordValue) {
                  //Do something with the user input.
                  _password = passwordValue;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password',
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              CustomButton(
                  color: Colors.blueAccent,
                  textName: 'Register',
                  onPressed: () async {
                    print('Email: $_email');
                    print('Password: $_password');
                    setState(() {
                      _showSpinner = true;
                    });
                    try {
                      final currentUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: _email, password: _password);
                      if (currentUser != null) {
                        Navigator.pushNamed(context, HomeScreen.id);
                      }
                      setState(() {
                        _showSpinner = false;
                      });
                    } catch (error) {
                      print('ERROR : $error');
                    }
                  }),
            ],
          ),
        ),
        inAsyncCall: _showSpinner,
      ),
    );
  }
}
