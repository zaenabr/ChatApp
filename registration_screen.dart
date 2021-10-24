import 'package:flutter/material.dart';
import 'package:untitled2/components/rounded_button.dart';
import 'package:untitled2/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}
class _RegistrationScreenState extends State<RegistrationScreen> {

  final _auth = FirebaseAuth.instance;

  bool showSpinner = false;
  String email;
  String password;
  String name;
  String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/e.jpg"),
                fit: BoxFit.cover)),
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: <Widget>[

                Flexible(
                  child: Hero(tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('images/log.png'),
                    ),
                  ),
                ),

                SizedBox(
                  height: 100.0,),

                TextField(
                  onChanged: (value) {
                    name=value;
                    //Do something with the user input.
                  },
                  decoration:kTextFieldDecoration.copyWith(
                      hintText: 'Name',
                      hintStyle: TextStyle(fontSize: 18.0, color: Colors.white60),
                      prefixIcon:Icon(Icons.person,color: Colors.white)),
                      style: TextStyle(color: Colors.white),
                ),

                SizedBox(height: 8.0,),

                TextField(
                  onChanged: (value) {
                    email=value;
                    //Do something with the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Email Address',
                      hintStyle: TextStyle(fontSize: 18.0, color: Colors.white60),
                      prefixIcon:Icon(Icons.email,color: Colors.white),),
                      style: TextStyle(color: Colors.white),
                ),


                SizedBox(height: 8.0,),

                TextField(
                  obscureText :true,
                  onChanged: (value) {
                    password=value;
                    //Do something with the user input.
                  },
                  decoration:kTextFieldDecoration.copyWith(
                      hintText: 'Password',
                      hintStyle: TextStyle(fontSize: 18.0, color: Colors.white60),
                      prefixIcon:Icon(Icons.vpn_key,color: Colors.white)),
                      style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 8.0,),

                TextField(
                  onChanged: (value) {
                   username=value;
                    //Do something with the user input.
                  },
                  decoration:kTextFieldDecoration.copyWith(
                      hintText: 'Username',
                      hintStyle: TextStyle(fontSize: 18.0, color: Colors.white60),
                      prefixIcon:Icon(Icons.alternate_email,color: Colors.white)),
                      style: TextStyle(color: Colors.white),
                ),

                RoundedButton(
                  title: 'Register',
                  colour: Colors.lightBlue,
                  onPressed: () async {
                    setState(() {
                      showSpinner=true;
                    });
                    try {
                      final newUser = await _auth.createUserWithEmailAndPassword(
                          email: email,
                          password: password);
                      if (newUser !=null ){
                        Navigator.pushNamed(context,'home_screen');

                        await _firestore.collection('users').doc(_auth.currentUser.uid).set({
                          "name" : name,
                          "email" : email,
                          "username" : username,

                        });
                      }
                      setState(() {
                        showSpinner=false;
                      });
                    }
                    catch(e){
                      print(e);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}