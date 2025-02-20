import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_first_app/screens/settings_screen.dart';
import 'package:mi_first_app/screens/onboarding_screen.dart';
import 'package:mi_first_app/screens/home_screen.dart';
import 'package:mi_first_app/screens/detail_screen.dart';

GoRouter createRouter(bool isFirstTime) {
  return GoRouter(
    initialLocation: isFirstTime ? '/onbording' : '/home', // Ruta inicial
    routes: [
      GoRoute(
        path: '/onbording',
        builder: (context, state) => OnboardingScreen(),
      ),

      GoRoute(
        path: '/home',
        pageBuilder: (context, state) => _customTransitionPageBuilder<void>(context,state,HomeScreen(),),
      ),

      GoRoute(
        path: '/detail',
        pageBuilder: (context, state) => _customTransitionPageBuilder<void>(context,state,DetailScreen(),),
      ),

      GoRoute(
        path: '/setting',
        pageBuilder: (context, state) => _customTransitionPageBuilder<void>(context,state,SettingsScreen(),),
      ),
    ],
  );
}

// Función de pageBuilder reutilizable para transiciones personalizadas
CustomTransitionPage _customTransitionPageBuilder<T>(
     BuildContext context,
     GoRouterState state,
     Widget child,
) {

  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0); // Deslizar desde la derecha
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      // Aplica una transición de deslizamiento
      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}
