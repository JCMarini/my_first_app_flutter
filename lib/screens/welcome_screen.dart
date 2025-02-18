import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../main_menu.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Bienvenido')),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            GoRouter.of(context).go("/home");
          },
          child: const Text('Iniciar'),
        ),
      ),
    );
  }
}