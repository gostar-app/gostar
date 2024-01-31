import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gostar/locator.dart';
import 'package:gostar/providers/user_provider.dart';
import 'package:gostar/repository/user_repo.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _syncUser() async {
    final user = locator<FirebaseAuth>().currentUser;

    if (user != null) {
      final userInfo =
          await Provider.of<UserProvider>(context, listen: false).getUserInfo();

      if (userInfo == null) {
        scheduleMicrotask(() => context.pushReplacement('/sign-in'));
      } else {
        scheduleMicrotask(() => context.pushReplacement('/tabs'));
      }
    } else {
      scheduleMicrotask(() => context.pushReplacement('/sign-in'));
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _syncUser();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Gostar Driver'),
      ),
    );
  }
}
