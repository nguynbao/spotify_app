import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify_app/model/users_model.dart';

class AuthRepositories {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  Future<UsersModel?> signUp(
    String email,
    String password,
    String fullName,
  ) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final uid = userCredential.user!.uid;
      // Lưu thông tin vào Firestore
      final userModel = UsersModel(uid: uid, email: email, name: fullName);
      await _firestore.collection('users').doc(uid).set(userModel.toMap());

      return userModel;
    } catch (e) {
      print('SignUp Error: $e');
      return null;
    }
  }

  Future<UsersModel?> login(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final uid = userCredential.user!.uid;

      final snapshot = await _firestore.collection('users').doc(uid).get();
      if (snapshot.exists && snapshot.data() != null) {
        return UsersModel.fromMap(snapshot.data()!, uid);
      } else {
        print('Login Error: User document does not exist in Firestore');
        return null;
      }
    } catch (e) {
      print('Login Error: $e');
      return null;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
