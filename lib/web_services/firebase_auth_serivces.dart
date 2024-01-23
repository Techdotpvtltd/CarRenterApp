import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  late FirebaseAuth _auth;
  FirebaseAuthService() {
    _auth = FirebaseAuth.instance;
  }

// Create New User ====================================
  Future<UserCredential> registerUser({
    required String email,
    required String password,
  }) async {
    final user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return user;
  }

  // Login User With Email ====================================
  Future<UserCredential> login(
      {required String withEmail, required String withPassword}) async {
    return await _auth.signInWithEmailAndPassword(
        email: withEmail, password: withPassword);
  }

// Send Reset Password Mail ====================================
  Future<void> resetPassword({required String email}) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  //  Logout User ====================================
  Future<void> logoutUser() async {
    await _auth.signOut();
  }
}
