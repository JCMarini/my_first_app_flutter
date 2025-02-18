import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Verificar si es la primera vez que el usuario abre la app
  final prefs = await SharedPreferences.getInstance();
  final isFirstTime = prefs.getBool('is_first_time') ?? true;

  // Si es la primera vez, marcar como no es la primera vez
  if (isFirstTime) {
    await prefs.setBool('is_first_time', false);
  }

  runApp(ProviderScope(child: MyApp(isFirstTime: isFirstTime)));
}

class MyApp extends StatefulWidget {
  final bool isFirstTime;


  const MyApp({Key? key, required this.isFirstTime}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: createRouter(widget.isFirstTime),
    );
  }
}