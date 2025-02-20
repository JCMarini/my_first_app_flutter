import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/theme_notifier.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final themeNotifier = ref.read(themeProvider.notifier);

    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              final goRouter = GoRouter.of(context);
              if (goRouter.canPop()) {
                goRouter.pop();
              } else {
                goRouter.go('/home');
              }
            },
          ),
        ),
        body: ListView(
          children: [
            SwitchListTile(
              title: Text('Modo oscuro'),
              value: themeMode == ThemeMode.dark,
              onChanged: (value) => themeNotifier.toggleTheme(),
            ),
          ],
        ),
      ),
    );
  }
}
