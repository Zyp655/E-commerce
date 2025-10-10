import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Widgets/show_scackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final googleSignIn = GoogleSignIn.instance;

  Future<String?> signup({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name.trim(),
        'email': email.trim(),
        'role': role,
      });
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      return userDoc['role'];
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<String?> sendPasswordResetEmail({
    required String email,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> signInWithGoogle({required BuildContext context}) async {
    try {

      const String serverClientId = "YOUR_SERVER_CLIENT_ID";

      final GoogleSignIn googleSignIn = GoogleSignIn.instance(
        serverClientId: serverClientId,
      );

      final GoogleSignInAccount? googleUser = await googleSignIn.authenticate();

      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        final DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(user.uid).get();

        if (!userDoc.exists) {
          await _firestore.collection('users').doc(user.uid).set({
            'name': user.displayName,
            'email': user.email,
            'role': 'User',
          });
          return 'User';
        } else {
          return userDoc['role'];
        }
      }
      return null;
    } on FirebaseAuthException catch (e) {
      if (context.mounted) _handleAuthException(e, context);
      return e.message;
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, 'An unexpected error occurred.');
        if (kDebugMode) {
          print(e);
        }
      }
      return e.toString();
    }
  }
}

void _handleAuthException(FirebaseAuthException e, BuildContext context) {
  String errorMessage = 'An unknown error occurred.';
  switch (e.code) {
    case 'account-exists-with-different-credential':
      errorMessage =
      'An account already exists with the same email address but different sign-in credentials.';
      break;
    case 'invalid-credential':
      errorMessage = 'The credential received is malformed or has expired.';
      break;
    case 'operation-not-allowed':
      errorMessage = 'Sign-in with this provider is not enabled.';
      break;
    case 'user-disabled':
      errorMessage = 'This user has been disabled.';
      break;
    case 'user-not-found':
      errorMessage = 'No user found for this credential.';
      break;
    default:
      errorMessage = 'An error occurred during sign-in. Please try again.';
  }
  showSnackBar(context, errorMessage);
}

