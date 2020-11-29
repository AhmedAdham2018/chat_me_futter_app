import 'package:chat_me/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/custom_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../constants.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _typedEmail;
  String _typedPassword;
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
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (emailValue) {
                  //Do something with the user input.
                  _typedEmail = emailValue;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your Email.'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (passwordValue) {
                  //Do something with the user input.
                  _typedPassword = passwordValue;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password.'),
              ),
              SizedBox(
                height: 24.0,
              ),
              CustomButton(
                  color: Colors.lightBlueAccent,
                  textName: 'Log In',
                  onPressed: () async {
                    setState(() {
                      _showSpinner = true;
                    });
                    try {
                      final signedUser = await _auth.signInWithEmailAndPassword(
                          email: _typedEmail, password: _typedPassword);
                      if (signedUser != null) {
                        Navigator.pushNamed(context, HomeScreen.id);
                      }
                      setState(() {
                        _showSpinner = false;
                      });
                    } catch (error) {
                      print('ERROR: $error');
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
