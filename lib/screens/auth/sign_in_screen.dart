import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:gostar/core/utils/ui_helper.dart';
import 'package:gostar/core/widgets/button/flexible_button.dart';
import 'package:gostar/providers/auth_provider.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

import '../../core/utils/state_handler.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  PhoneNumber phoneNo = PhoneNumber(
    dialCode: '+91',
    isoCode: 'IN',
  );

  bool _isPasswordVisible = false;

  _signUpUser(BuildContext context) async {
    final no = phoneNo.phoneNumber;
    if (no != null) {
      Provider.of<AuthenticationProvider>(context, listen: false).sendCode(
        no,
        (vid) => scheduleMicrotask(() => context.go('/otp', extra: vid)),
      );
    }
  }

  String capitalizedName() {
    String text = _nameController.text;
    _nameController.value = _nameController.value.copyWith(
      text: text.split(' ').map((word) {
        if (word.isNotEmpty) {
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        }
        return word;
      }).join(' '),
      selection: TextSelection.collapsed(offset: _nameController.text.length),
    );
    return _nameController.text;
  }

  _togglePasswordVisiblity() {
    _isPasswordVisible = !_isPasswordVisible;
    setState(() {});
  }

  _navigateToSignIn() {
    Provider.of<AuthenticationProvider>(context, listen: false).handleEmpty();
    context.pushReplacement('/sign-in');
  }

  _navigateToTabsScreen() {
    context.pushReplacement('/tabs');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: space2x),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 150.h),
              // Hero(
              //   tag: 'app_icon',
              //   child: SizedBox(
              //     width: 100.r,
              //     height: 100.r,
              //     child: CircleAvatar(
              //       radius: 60,
              //       backgroundImage: Image.asset('assets/app_icon.png').image,
              //     ),
              //   ),
              // ),
              SizedBox(height: space2x.h),
              Text(
                'Gostar Driver',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: space6x.h),
              Consumer<AuthenticationProvider>(
                builder: (context, provider, child) {
                  if (provider.state == ProviderState.loaded) {
                    scheduleMicrotask(() {
                      provider.handleEmpty();
                    });
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      InternationalPhoneNumberInput(
                        initialValue: phoneNo,
                        inputDecoration: const InputDecoration(),
                        selectorTextStyle: TextStyle(fontSize: 18.r),
                        textStyle: TextStyle(fontSize: 20.r),
                        selectorConfig: SelectorConfig(
                          selectorType: PhoneInputSelectorType.DROPDOWN,
                          leadingPadding: 0,
                          trailingSpace: false,
                          setSelectorButtonAsPrefixIcon: true,
                          useEmoji: true,
                          countryComparator: (a, b) =>
                              a.name!.compareTo(b.name!),
                        ),
                        onInputChanged: (PhoneNumber value) {
                          setState(() {
                            phoneNo = value;
                          });
                        },
                      ),
                      SizedBox(height: space2x.h),
                      Text(
                        provider.errorMessage.message,
                        style: TextStyle(fontSize: 14.r, color: Colors.red),
                      ),
                      SizedBox(height: 40.h),
                      FlexibleButton(
                        text: 'Send code',
                        onPressed: () => _signUpUser(context),
                        isLoading: provider.state == ProviderState.loading,
                        width: double.infinity,
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: space1x.h),
              TextButton(
                onPressed: _navigateToSignIn,
                child: const Center(
                  child: Text(
                    "Have an account already? Login here",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
