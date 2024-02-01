import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  // create instance 
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> getCurrentUser() async {
    return FirebaseAuth.instance.currentUser;
  }

  // sign in with email & Password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      return null;
    }
  }

}



