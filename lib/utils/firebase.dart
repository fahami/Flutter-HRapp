import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hrapp/view/components/snackbars.dart';

abstract class AuthenticationFirebase {
  Future<UserCredential> signInWithGoogle();
  Future<void> sendEmailVerification(BuildContext context);
  Future<void> resetPassword(BuildContext context, String email);
}

class FirebaseUtils implements AuthenticationFirebase {
  final _auth = FirebaseAuth.instance;

  @override
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Future<void> sendEmailVerification(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null && !user.emailVerified) {
      showSnackbar(context, 'Sending email verificatiton');
      await user.sendEmailVerification();
    }
  }

  @override
  Future<void> resetPassword(BuildContext context, String email) async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .then((value) => showSnackbar(
            context, 'Reset password was send to your email: $email'))
        .onError((error, _) => showSnackbar(context, error.toString()));
  }
}
