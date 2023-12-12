import 'package:flutter/material.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {

  static const String id='login_screen';


  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool showSpinner=false;
  final _auth=FirebaseAuth.instance;
  late String email;
  late String pwd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall:showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag:'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email=value;
                },
                decoration: textFieldDecoration2.copyWith(
                  hintText: 'Enter your email',
                  prefixIcon: Icon(Icons.email),
                  //hintStyle: TextStyle(color: Colors.black26),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                 pwd=value;
                },
                decoration: textFieldDecoration2.copyWith(
                  hintText: 'Enter your password',
                  prefixIcon: Icon(Icons.lock),
                  //hintStyle: TextStyle(color: Colors.black26),
                ),
              ),
              SizedBox(
                height: 35.0,
              ),
              RoundedButton(
                colour: Colors.lightBlueAccent,
                title: 'Log In',
                onpress: () async{
                  // setState(() {
                  //   showSpinner=true;
                  // });
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: pwd);
                    if (user != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    // setState(() {
                    //   showSpinner=false;
                    // });
                  }
                  catch(e){
                    print(e);
                  }
                }
               ),
            ],
          ),
        ),
      ),
    );
  }
}