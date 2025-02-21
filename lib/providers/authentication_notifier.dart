import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum AuthStatus { authenticated, unauthenticated, loading }

class AuthState {
  final AuthStatus status;
  final String? userId;
  final String? displayName;
  final String? email;

  AuthState({
    required this.status,
    this.userId,
    this.displayName,
    this.email,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? userId,
    String? displayName,
    String? email,
  }) {
    return AuthState(
      status: status ?? this.status,
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthNotifier() : super(AuthState(status: AuthStatus.unauthenticated));
  // Método para cerrar sesión
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
    state = state.copyWith(status: AuthStatus.unauthenticated);
  }
}