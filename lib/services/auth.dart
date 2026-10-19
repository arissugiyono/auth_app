import 'package:auth_app/models/firebaseUser.dart';
import 'package:auth_app/models/loginUser.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInAnonymously() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _firebaseUser(user);
    } catch (e) {
      return FirebaseUser(code: e.toString(), uid: null);
    }
  }

  Future signInWithEmailAndPassword(LoginUser _login) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: _login.email.toString(), password: _login.password.toString());
      User? user = result.user;
      return _firebaseUser(user);
    }on FirebaseAuthException catch (e) {
      return FirebaseUser(code: e.code, uid: null);
    }
  }

  Future registerWithEmailAndPassword(LoginUser _login) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: _login.email.toString(), password: _login.password.toString());
      User? user = result.user;
      return _firebaseUser(user);
    }on FirebaseAuthException catch (e) {
      return FirebaseUser(code: e.code, uid: null);
    } catch (e) {
      return FirebaseUser(code: e.toString(), uid: null);
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }

  FirebaseUser? _firebaseUser(User? user) {
    return user != null ? FirebaseUser(uid: user.uid) : null;
  }


  Stream<FirebaseUser?> get user {
    return _auth.authStateChanges().map(_firebaseUser);
  }


}
