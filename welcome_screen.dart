import 'package:flutter/material.dart';
import 'package:untitled2/components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/t.jpg"),
                fit: BoxFit.cover)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    child: Image.asset('images/logo.png'),
                    height: 150.0,
                  ),
                ],
              ),
              SizedBox(height: 48.0,),

              RoundedButton(
                title:'Log In',
                colour: Colors.lightBlue,
                onPressed:(){
                Navigator.pushNamed(context, 'login_screen');
              },),

              RoundedButton(
                title:'Register',
                colour: Colors.lightBlue,
                onPressed:(){
                Navigator.pushNamed(context, 'registration_screen');
              },),
            ],
          ),
        ),
      ),
    );
  }
}

