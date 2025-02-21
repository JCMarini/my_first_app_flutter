import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends ConsumerWidget {
  // El tiempo que tarda en la animación
  Duration get loginTime => Duration(milliseconds: 2250);
  final FirebaseAuth _auth = FirebaseAuth.instance;

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

  // Método de inicio de sesión con Google
  Future<String?> _signInWithGoogle(BuildContext context, WidgetRef ref) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        return 'Error: el usuario cancelo el login con google';
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      // Aquí puedes usar Riverpod para actualizar el estado de autenticación
      // ref.read(authProvider.notifier);

      debugPrint('Se inicio sesion desde google : ' + userCredential.user.toString());
      return null; // Significa que la autenticación fue exitosa
    } catch (e) {
      return 'Error: ${e.toString()}'; // ⚠️ Muestra error en pantalla
    }
  }

  // Metodo para recuperar tu contraseña
  Future<String> _recoverPassword(String email) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return "Email de recuperación invalido"; // ✅ Email de recuperación enviado
    } catch (e) {
      return 'Error: ${e.toString()}'; // ⚠️ Muestra error en pantalla
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Si el usuario no está autenticado, mostramos el formulario de login
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
            _signInWithGoogle(context, ref);
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
