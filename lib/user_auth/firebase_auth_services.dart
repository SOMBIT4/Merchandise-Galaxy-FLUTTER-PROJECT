import 'package:firebase_auth/firebase_auth.dart';

class Firebaseauthservice {
  FirebaseAuth _auth = FirebaseAuth.instance;
  //signup method
  Future<User?> signupwithemailandpassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print("Some error occured");
      return null;
    }
  }

  //signin method
  Future<User?> signinwithemailandpassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print("Some error occured");
    }
    return null;
  }
}
