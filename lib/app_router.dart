import 'package:flutter/material.dart';
import 'package:shop/constants/namepage.dart';
import 'package:shop/view/screens/bottom_nav_screens/search_screen.dart';
import 'package:shop/view/screens/login_screen.dart';
import 'package:shop/view/screens/on_boarding_screen.dart';
import 'package:shop/view/screens/register.dart';
import 'package:shop/view/screens/shoplayout.dart';

class AppRouter {
  Route? generatorRouter(RouteSettings settings) {
    switch (settings.name) {
      case pageViewScreen:
        return MaterialPageRoute(
          builder: (_) => const OnBoardingScreen(),
        );
      case loginScreen:
        return MaterialPageRoute(
          builder: (_) {
            return LoginScreen();
          },
        );
      case registerScreen:
        return MaterialPageRoute(
          builder: (_) {
            return RegisterScreen();
          },
        );

      case shopLayout:
        return MaterialPageRoute(
          builder: (_) {
            return const ShopLayout();
          },
        );
      case searchScreen:
        return MaterialPageRoute(
          builder: (_) {
            return SearchScreen();
          },
        );
    }
    return null;
  }
}
