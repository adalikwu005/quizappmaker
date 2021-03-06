import 'package:flutter/material.dart';
import 'package:quizmaker/helper/functions.dart';
import 'package:quizmaker/services/auth.dart';
import 'package:quizmaker/views/signup.dart';
import 'package:quizmaker/widgets/widgets.dart';
import 'package:flutter/widgets.dart';

import 'home.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  String email, password;
  AuthService authService = new AuthService();

  bool _isLoading = false;



  signIn() async{
    if (_formKey.currentState.validate()) {

      setState(() {
        _isLoading = true;
      });
      await authService.signInEmailAndPass(email, password).then((val){
        if(val != null) {
          setState(() {
            _isLoading = false;
          });
          HelperFunctions.saveUserLoggedInDetails(isLoggedIn: true);
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => Home()
          ));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        centerTitle: true,
      ),
      body: _isLoading ? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ) : Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: <Widget>[
              Spacer(),
              TextFormField(
                validator: (val) {
                  return val.isEmpty ? "Enter Email id" : null;
                },
                decoration: InputDecoration(hintText: "Email"),
                onChanged: (val) {
                  email = val;
                },
              ),
              SizedBox(
                height: 6,
              ),
              TextFormField(
                obscureText: true,
                validator: (val) {
                  return val.isEmpty ? "Enter Password" : null;
                },
                decoration: InputDecoration(hintText: "Password"),
                onChanged: (val) {
                  password = val;
                },
              ),
              SizedBox(
                height: 24,
              ),
              GestureDetector(
                onTap: (){
                  signIn();
                },
                child: blueButton(context: context, label: "Sign In")
              ),
              SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(fontSize: 15.5),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => SignUp()));
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 16.5,
                            decoration: TextDecoration.underline),
                      ))
                ],
              ),
              SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
