import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mi_first_app/providers/first_launch_notifier.dart';
import 'package:mi_first_app/providers/theme_notifier.dart';
import 'package:mi_first_app/screens/theme.dart';
import 'firebase_options.dart';
import 'router.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isFirstLaunch = ref.watch(firstLaunchProvider);
    
    return MaterialApp.router(
      title: 'My First APP Flutter',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      routerConfig: createRouter(isFirstLaunch),
      debugShowCheckedModeBanner: false,
    );
  }
}

