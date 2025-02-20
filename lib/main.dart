import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mi_first_app/providers/first_launch_notifier.dart';
import 'package:mi_first_app/providers/theme_notifier.dart';
import 'package:mi_first_app/screens/theme.dart';
import 'router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isFirstLaunch = ref.watch(firstLaunchProvider);
    
    return MaterialApp.router(
      title: 'App Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      routerConfig: createRouter(isFirstLaunch),
      debugShowCheckedModeBanner: false,
    );
  }
}

