import 'dart:async';

import 'package:flutter/material.dart';

import '../../utils/navigation.dart';

enum AuthStatus { loading, authenticated, unAuthenticated }

class AuthWidget extends StatefulWidget {
  const AuthWidget({
    Key? key,
    required this.splashScreen,
    required this.authenticated,
    required this.unAuthenticated,
    this.onAuthenticated,
  }) : super(key: key);

  ///Widget to be shown on authenticated
  final Widget authenticated;

  ///Widget to be shown when unauthenticated
  ///
  ///Eg. Login Screen
  final Widget unAuthenticated;

  ///Widget to be shown while fetching data
  final Widget splashScreen;

  final VoidCallback? onAuthenticated;

  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  AuthStatus _status = AuthStatus.loading;

  @override
  void initState() {
    _syncUser();

    super.initState();
  }

  Future<void> _syncUser() async {
    //Check for user here

    _status = AuthStatus.unAuthenticated;
    await Future.delayed(const Duration(milliseconds: 450));
    setState(() {});
  }

  _navigate(Widget screen) {
    scheduleMicrotask(() {
      Navigation.pushReplacement(
        context,
        screen: screen,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_status == AuthStatus.authenticated) {
      _navigate(widget.authenticated);
    } else if (_status == AuthStatus.unAuthenticated) {
      _navigate(widget.unAuthenticated);
    }
    return widget.splashScreen;
  }
}
