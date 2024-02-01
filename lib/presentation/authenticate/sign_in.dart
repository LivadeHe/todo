import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/presentation/item/item_list_widget.dart';
import 'package:todo/infrastructure/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignIn extends StatefulWidget {
  //const SignIn({super.key});
  const SignIn({Key? key}) : super(key: key );
  @override
  //State<SignIn> createState() => _SignInState();
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = ""; 

  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(184, 185, 185, 1),
      
      appBar: AppBar(
        
        backgroundColor: Colors.pink[100],
        elevation: 0.0,
        centerTitle: true,
        title: Text(
        'Sign in to My To Do List'),
        ), 
        body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                ),
                validator: (String? val) {
                  if (val == null || val.isEmpty) {
                    return 'Enter an email';
                  }
                  return null;
                },
                onChanged: (String val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                ),
                obscureText: true,
                validator: (String? val) {
                  if (val == null || val.length < 6) {
                    return 'Enter a password 6+ chars long';
                  }
                  return null;
                },
                onChanged: (String val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                 style: ElevatedButton.styleFrom(
                    primary: Colors.pink[400], 
                  ),
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if (result == null) {
                      setState(() {
                        error = 'Could not sign in with those credentials';
                      });
                    } else {
                      // Erfassung der Benutzerinformationen und Weiterleitung zur Todo-Liste
                      User? user = await _auth.getCurrentUser();
                      if (user != null) {
                        Get.to(ItemListWidget(userId: user.uid));
                      }
                    }
                  }
                },
                child: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );


  }
}