import 'package:flutter/material.dart';
import 'package:todo/presentation/authenticate/sign_in.dart';

// Ruft Sign_in.dart auf
class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SignIn(),
    );
  }
}