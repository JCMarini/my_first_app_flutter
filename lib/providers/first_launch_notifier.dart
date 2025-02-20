// Estado del tema (Light/Dark)
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstLaunchNotifier extends StateNotifier<bool> {
  static const String _keyFirstLaunch = "first_launch";

  FirstLaunchNotifier() : super(false) {
    _loadFirstTimeLaunch(); // Cargar la preferencia guardada al iniciar
  }

  Future<void> _loadFirstTimeLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstLaunch = prefs.getBool(_keyFirstLaunch) ?? true;
    state = isFirstLaunch;
  }

  // Cambiar el tema y guardar la preferencia
  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyFirstLaunch, false);
    state = false;
  }
}

// Provider para acceder al estado de la ejecucion
final firstLaunchProvider = StateNotifierProvider<FirstLaunchNotifier, bool>((ref) {
  return FirstLaunchNotifier();
});