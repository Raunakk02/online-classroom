import '../utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login/flutter_login.dart';
import '../utils/globals.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      onSignup: onSignUp,
      onLogin: onLogin,
      title: 'CLASSROOM',
      userType: LoginUserType.name,
      loginProviders: [
        LoginProvider(
          icon: FontAwesomeIcons.google,
          callback: signInWithGoogle,
        )
      ],
      theme: LoginTheme(
        primaryColor: ColorsUtils.kPrimaryColor,
        pageColorDark: ColorsUtils.kBackgroundColor,
        pageColorLight: ColorsUtils.kBackgroundColor,
        bodyStyle: GoogleFonts.roboto(
          color: ColorsUtils.kTextColor,
        ),
        textFieldStyle: GoogleFonts.montserrat(
          color: ColorsUtils.kTextColor,
        ),
        titleStyle: GoogleFonts.montserrat(
          fontSize: 4.w,
        ),
        buttonTheme: LoginButtonTheme(
          backgroundColor: ColorsUtils.kPrimaryColor,
        ),
      ),
      onRecoverPassword: resetPassword,
      onSubmitAnimationCompleted: () {},
    );
  }

  Future<String?>? onSignUp(LoginData data) async {
    print('Trying to sign in');
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: data.name, password: data.password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for this email.';
      }
    } catch (e) {
      print(e);
    }
    print('Successfully Signed Up');
  }

  Future<String?>? onLogin(LoginData data) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: data.name, password: data.password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    }
  }

  Future<String?>? signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) return 'No User Selected';

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);
    } on PlatformException catch (err) {
      if (err.code == 'sign_in_failed') return 'Could not sign in with Google';
    }
  }

  Future<String?>? resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') return 'Invalid Email';
      if (err.code == 'user-not-found') return 'No User exists with this email';
    }
  }
}
