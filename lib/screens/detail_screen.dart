import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailScreen extends StatelessWidget {

  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! < 0) { // Swipe
          GoRouter.of(context).go('/home'); // Regresar a Home
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Detalles'),
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
        // drawer: const MainMenu(),
        body: Center(
          child: Text('Page Details:', style: TextStyle(fontSize: 24)),
        ),
      ),
    );
  }
}
