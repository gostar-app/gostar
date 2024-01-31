import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:gostar/providers/auth_provider.dart';
import 'package:gostar/providers/user_provider.dart';
import 'package:gostar/providers/vehicle_provider.dart';
import 'package:gostar/repository/auth_repo.dart';
import 'package:gostar/repository/user_repo.dart';
import 'package:gostar/repository/vehicle_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> init() async {
  ///Providers
  locator.registerLazySingleton(
      () => AuthenticationProvider(locator(), locator(), locator()));
  locator.registerLazySingleton(() => UserProvider(locator()));
  locator.registerLazySingleton(() => VehicleProvider(locator()));

  ///Repos
  locator.registerLazySingleton(() => AuthRepo(locator(), locator()));
  locator.registerLazySingleton(() => VehicleRepo(locator(), locator()));
  locator
      .registerLazySingleton(() => UserRepo(locator(), locator(), locator()));

  ///Services
  final SharedPreferences _prefs = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => _prefs);

  locator.registerLazySingleton(() => FirebaseAuth.instance);
  locator.registerLazySingleton(() => FirebaseStorage.instance);
  locator.registerLazySingleton(() => FirebaseFirestore.instance);
}
