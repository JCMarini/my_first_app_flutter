import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_first_app/providers/first_launch_notifier.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              children: [
                OnboardingPage(
                  image: 'assets/images/badger1.jpg',
                  title: "Bienvenido a la App",
                  description: "Explora todas las funciones que hemos preparado para ti.",
                ),
                OnboardingPage(
                  image: 'assets/images/badger2.jpg',
                  title: "Encuentra lo que necesitas",
                  description: "Accede fácilmente a todas las opciones.",
                ),
                OnboardingPage(
                  image: 'assets/images/badger3.jpg',
                  title: "Comienza ahora",
                  description: "Disfruta de todas las características sin problemas.",
                ),
              ],
            ),
          ),
          _buildBottomSection(),
        ],
      ),
    );
  }

  Widget _buildBottomSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SmoothPageIndicator(
            controller: _pageController,
            count: 3,
            effect: WormEffect(dotHeight: 10, dotWidth: 10, activeDotColor: Colors.blue),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              if (_currentPage < 2) {
                _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
              } else {
                // Guardar en SharedPreferences que el usuario ya vio el Onboarding
                ref.read(firstLaunchProvider.notifier).completeOnboarding();
                // Navegar a la pantalla principal
                GoRouter.of(context).go("/home");
              }
            },
            child: Text(_currentPage < 2 ? "Siguiente" : "Empezar"),
          ),
          TextButton(
            onPressed: () {
              GoRouter.of(context).go("/home");
            },
            child: Text("Omitir"),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String image, title, description;

  const OnboardingPage({required this.image, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 200),
          SizedBox(height: 20),
          Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text(description, textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}