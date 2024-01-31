import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:gostar/firebase_options.dart';
import 'package:gostar/locator.dart';
import 'package:gostar/providers/auth_provider.dart';
import 'package:gostar/providers/user_provider.dart';
import 'package:gostar/providers/vehicle_provider.dart';
import 'package:gostar/screens/auth/create_account_screen.dart';
import 'package:gostar/screens/auth/sign_in_screen.dart';
import 'package:gostar/screens/auth/sign_up_screen.dart';
import 'package:gostar/screens/auth/splash_screen.dart';
import 'package:gostar/screens/auth/verify_otp_screen.dart';
import 'package:gostar/screens/tabs/tabs_screen.dart';
import 'package:gostar/screens/vehicle/add_vehicle_info.dart';
import 'package:gostar/screens/vehicle/upload_documents.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //Injecting dependency
  await init();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => locator<AuthenticationProvider>()),
      ChangeNotifierProvider(create: (_) => locator<UserProvider>()),
      ChangeNotifierProvider(create: (_) => locator<VehicleProvider>()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Gostar Driver',
          theme: ThemeData(
              fontFamily: 'Inter',
              primaryColor: Colors.black,
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.grey.shade50,
                elevation: 0,
                iconTheme: IconThemeData(
                  size: 20.r,
                ),
                titleTextStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 18.r,
                ),
              ),
              useMaterial3: false,
              colorScheme: const ColorScheme.light().copyWith(
                primary: Colors.black,
                onPrimary: Colors.white,
              )),
          routerConfig: _router,
        );
      },
    );
  }
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/sign-in',
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: '/sign-up',
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: '/otp',
      builder: (context, state) => const VerifyOTPScreen(),
    ),
    GoRoute(
      path: '/create-account',
      builder: (context, state) => const CreateAccountScreen(),
    ),
    GoRoute(
      path: '/tabs',
      builder: (context, state) => const TabsScreen(),
    ),
    GoRoute(
      path: '/add-vehicle',
      builder: (context, state) => const AddVehicleInfo(),
    ),
    GoRoute(
      path: '/upload-documents',
      builder: (context, state) => const UploadDocuments(),
    ),
  ],
);
