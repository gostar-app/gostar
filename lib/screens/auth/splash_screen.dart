import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:gostar/core/animations/scale_animation.dart';
import 'package:gostar/locator.dart';
import 'package:gostar/providers/user_provider.dart';
import 'package:gostar/repository/user_repo.dart';
import 'package:gostar/screens/auth/sign_in_screen.dart';
import 'package:gostar/screens/tabs/tabs_screen.dart';
import 'package:provider/provider.dart';

import '../../core/animations/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 0.6,
      upperBound: 28,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  _syncUser(BuildContext context, AnimationController controller) async {
    final user = locator<FirebaseAuth>().currentUser;

    if (user != null) {
      final userInfo =
          await Provider.of<UserProvider>(context, listen: false).getUserInfo();

      if (userInfo == null) {
        // scheduleMicrotask(() => context.pushReplacement('/sign-in'));
        navigate(const SignInScreen());
      } else {
        navigate(const TabsScreen());
        // scheduleMicrotask(() => context.pushReplacement('/tabs'));
      }
    } else {
      navigate(const SignInScreen());
      // scheduleMicrotask(() => context.pushReplacement('/sign-in'));
      // Navigator.of(context).push(PageTransitionsBuilder((_) => const SignInScreen())));
      //Do custom page transition
    }
  }

  navigate(Widget screen) async {
    await Future.delayed(const Duration(milliseconds: 1350));
    _animationController.forward();
    await Future.delayed(const Duration(milliseconds: 450));
    scheduleMicrotask(() {
      Navigator.of(context).push(PageTransition(
        child: screen,
        type: PageTransitionType.scaleUpWithFadeIn,
        curve: Curves.fastOutSlowIn,
        duration: const Duration(milliseconds: 400),
      ));
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _syncUser(context, _animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedBuilder(
          animation: CurvedAnimation(
              curve: Curves.fastOutSlowIn, parent: _animationController),
          builder: (_, child) {
            return Transform.scale(
              scale: _animationController.value,
              child: child,
            );
          },
          child: const Icon(Icons.star, size: 100, color: Colors.white),
        ),

        // ScaleTransition(
        //   scale:
        //   _controller,
        //   // CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
        //   child: Icon(Icons.star, size: 100, color: Colors.white),
        // ),
      ),
    );
  }
}
