import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  Duration get loginTime => const Duration(milliseconds: 2250);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<String?> _authUser(LoginData data) async {
    // login con firebase
    try {
      await _auth.signInWithEmailAndPassword(
        email: data.name,
        password: data.password,
      );
      return null; // ✅ Login exitoso
    } catch (e) {
      return 'Error: ${e.toString()}'; // ⚠️ Muestra error en pantalla
    }
  }

  Future<String?> _signupUser(SignupData data) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: data.name!,
        password: data.password!,
      );
      return null; // ✅ Registro exitoso
    } catch (e) {
      return 'Error: ${e.toString()}'; // ⚠️ Muestra error en pantalla
    }
  }

  Future<String> _recoverPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return "Email de recuperación invalido"; // ✅ Email de recuperación enviado
    } catch (e) {
      return 'Error: ${e.toString()}'; // ⚠️ Muestra error en pantalla
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Login',
      logo: const AssetImage('assets/images/badger1.jpg'),
      onLogin: _authUser,
      onSignup: _signupUser,

      loginProviders: <LoginProvider>[
        LoginProvider(
          icon: FontAwesomeIcons.google,
          label: 'Google',
          callback: () async {
            try {
              final GoogleSignInAccount? googleUser =
                  await _googleSignIn.signIn();
              if (googleUser == null)
                return; // El usuario canceló el inicio de sesión

              final GoogleSignInAuthentication googleAuth =
                  await googleUser.authentication;

              final AuthCredential credential = GoogleAuthProvider.credential(
                accessToken: googleAuth.accessToken,
                idToken: googleAuth.idToken,
              );

              UserCredential userCredential =
                await _auth.signInWithCredential(credential,);

              if (userCredential.user != null) {
                debugPrint("Login exitoso: ${userCredential.user!.email}");
                GoRouter.of(context).go("/home");
              } else {
                debugPrint("Error: No se pudo obtener el usuario");
              }
            } catch (e) {
              debugPrint("Error al iniciar sesión con Google: $e");
            }
          },
        ),
        LoginProvider(
          icon: FontAwesomeIcons.facebookF,
          label: 'Facebook',
          callback: () async {
            debugPrint('start facebook sign in');
            await Future.delayed(loginTime);
            debugPrint('stop facebook sign in');
            return null;
          },
        ),
      ],
      onSubmitAnimationCompleted: () {
        GoRouter.of(context).go("/home");
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
