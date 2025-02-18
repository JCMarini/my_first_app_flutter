import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/counter_provider.dart';

class DetailScreen extends ConsumerWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Se esta leyendo el estado del contador.
    final counter = ref.watch(counterProvider);

    return  GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! < 0) { // Swipe
          GoRouter.of(context).go('/home'); // Regresar a Home
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Details'),
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
        body: Center(
          child: Text('Page Details: $counter', style: TextStyle(fontSize: 24)),
        ),
      ),
    );
  }
}
