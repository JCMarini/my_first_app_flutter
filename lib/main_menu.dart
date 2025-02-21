import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_first_app/providers/authentication_provider.dart';

class MainMenu extends ConsumerWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(child: Text('Menú')),
          ElevatedButton.icon(
            onPressed: () async {
              await ref.read(authProvider.notifier).signOut();
              context.go('/login'); // Regresa a la pantalla de login
            },
            icon: Icon(Icons.exit_to_app, color: Colors.white), // Icono de salida
            label: Text("Salir"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, // Color de fondo
              foregroundColor: Colors.white, // Color del texto
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              context.go('/home');
            },
          ),
          ListTile(
            leading: Icon(Icons.details),
            title: const Text('Details'),
            onTap: () {
              context.go('/detail');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              context.go('/setting');
            },
          ),
        ],
      ),
    );
  }
}
