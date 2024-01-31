import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:gostar/core/utils/state_handler.dart';
import 'package:gostar/core/utils/ui_helper.dart';
import 'package:gostar/core/widgets/button/flexible_button.dart';
import 'package:gostar/providers/auth_provider.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class VerifyOTPScreen extends StatefulWidget {
  const VerifyOTPScreen({super.key});

  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  final TextEditingController _pinController = TextEditingController();

  _verfiyOtp() async {
    final String vid = GoRouterState.of(context).extra! as String;
    final otp = _pinController.text;

    await Provider.of<AuthenticationProvider>(context, listen: false)
        .verifyCode(context, otp, vid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: space2x, vertical: space7x),
        child: Consumer<AuthenticationProvider>(
          builder: (context, provider, child) {
            if (provider.state == ProviderState.success) {
              scheduleMicrotask(() {
                provider.handleEmpty();
              });
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Verify your number',
                  style: TextStyle(fontSize: 22.r, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 40.h),
                Pinput(
                  controller: _pinController,
                  length: 6,
                  onCompleted: (pin) {
                    _verfiyOtp();
                  },
                ),
                SizedBox(height: space2x.h),
                Text(
                  provider.errorMessage.message,
                  style: TextStyle(fontSize: 14.r, color: Colors.red),
                ),
                SizedBox(height: space4x.h),
                FlexibleButton(
                  text: 'Verify',
                  onPressed: () => _verfiyOtp(),
                  width: double.infinity,
                  isLoading: provider.state == ProviderState.loading,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
