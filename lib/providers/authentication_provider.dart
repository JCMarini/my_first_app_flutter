import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'authentication_notifier.dart';

// Estado del contador
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});