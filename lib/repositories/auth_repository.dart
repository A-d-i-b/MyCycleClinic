import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<void> signUp(
      {required String email,
      required String password,
      required String mobile,
      required String name}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseAuth.instance.currentUser?.updateDisplayName(name);

      String? userUid = FirebaseAuth.instance.currentUser?.uid;
      // SHOULD WE KEEP IT USERID OR EMAIL? DEPENDS ON THE OTHER CART AND STORE IMPLEMENTATIONS.
      await FirebaseFirestore.instance.collection('users').doc(userUid).set({
        "email": email,
        "mobile": mobile,
        "userUid": userUid,
        "name": name,
        "count": 1,
      });
      await FirebaseFirestore.instance.collection("cart").doc(email).set({
        "storeid": "",
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }

  //FirebaseAuth.instance.sendPasswordResetEmail(email: _email);

  Future<void> resetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception(e);
    }
  }
}
