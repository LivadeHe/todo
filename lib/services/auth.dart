//import '../infrastructure/user.dart';
import 'package:firebase_auth/firebase_auth.dart';




class AuthService {

  // create instance 
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> getCurrentUser() async {
    return FirebaseAuth.instance.currentUser;
  }

 /* User _userFromFirebaseUser(User user) {
    return user != null ? User(uid: user.uid) : null;
  }
  */

  // sign in anonymous
  /*Future signInAnonymous() async {
    try {
      UserCredential result =await _auth.signInAnonymously();
      User user = result.user;
      return user;

    } catch (error) {
      print(error.toString());
      return null;

    }
   
    

  }*/



  // sign in with email & Password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return null;
    }
  }

  // register with email & password
  Future createUserWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
  // sign out

}



