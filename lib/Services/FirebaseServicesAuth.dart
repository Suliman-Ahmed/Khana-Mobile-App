import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseAuthServices {
  final FirebaseAuth _auth;

  FirebaseAuthServices(this._auth);

  Stream<User> get authStateChange => _auth.authStateChanges();

  Future<void> signOut() async{
    await _auth.signOut();
  }

  Future<String> signIn({String email, String password}) async {
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return 'Sign in successfully';
    } on FirebaseAuthException catch(e){
      return e.message;
    }
  }
}
