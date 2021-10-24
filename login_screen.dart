import 'package:flutter/material.dart';
import 'package:untitled2/components/rounded_button.dart';
import 'package:untitled2/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {

  final _auth = FirebaseAuth.instance;

  bool showSpinner=false;
  String email;
  String password;

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
                  child: Hero(tag: 'log',
                    child: Container(
                     height: 200.0,
                      child: Image.asset('images/logo[1].png'),
                  ),),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextField(
                  onChanged: (value) {
                    email= value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Email',
                      hintStyle: TextStyle(fontSize: 18.0, color: Colors.white60),
                      prefixIcon: Icon(Icons.email,color: Colors.white,)),
                  style: TextStyle(color: Colors.white),
                ),

                SizedBox(height: 8.0,),

                TextField(
                  obscureText :true,
                  onChanged: (value) {
                    password= value;
                  },
                   decoration: kTextFieldDecoration.copyWith(
                       hintText: 'Password',
                       hintStyle: TextStyle(fontSize: 18.0, color: Colors.white60),
                       prefixIcon: Icon(Icons.lock_outline,color: Colors.white,)
                   ),
                       style: TextStyle(color: Colors.white),
                ),

                SizedBox(
                  height: 24.0,),


                RoundedButton(
                  title: 'Log In',
                  colour: Colors.lightBlue,
                  onPressed:() async{
                    setState(() {
                      showSpinner=true;
                    });
                    try{
                    final user =await _auth.signInWithEmailAndPassword(
                        email: email,
                        password: password);
                    if (user != null) {
                      Navigator.pushNamed(context, 'home_screen');
                    }
                    setState(() {
                      showSpinner=false;
                    });
                  }
                    catch(e){
                    print(e);
                 }
                },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}