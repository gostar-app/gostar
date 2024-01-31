import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:gostar/models/app_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepo {
  final FirebaseFirestore _db;
  final FirebaseAuth _auth;
  final SharedPreferences _prefs;

  UserRepo(this._db, this._auth, this._prefs);

  Future<void> registerDriver(
    String uid,
    String phoneNo,
    String email,
    String name,
    String city,
    String profileImg,
  ) async {
    try {
      await _db.collection('users').doc(uid).set({
        'phoneNo': phoneNo,
        'name': name,
        'uid': uid,
        'email': email,
        'city': city,
        'profileImg': profileImg,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint('Error at User Repo register: $e');
      throw UserException('Something went wrong');
    }
  }

  User? getCurrentUser() {
    return _auth.currentUser!;
  }

  Future<bool> doesUserhasAccount(
      {String? uid, String? email, String? phoneNo}) async {
    if (uid != null) {
      bool exists =
          await _db.doc('users/$uid').get().then((value) => value.exists);
      return exists;
    } else if (phoneNo != null) {
      bool exists = await _db
          .collection('users')
          .where('phoneNo', isEqualTo: phoneNo)
          .get()
          .then((snaps) => snaps.docs.isNotEmpty);
      return exists;
    } else if (email != null) {
      bool exists = await _db
          .collection('users')
          .where('email', isEqualTo: phoneNo)
          .get()
          .then((snaps) => snaps.docs.isNotEmpty);
      return exists;
    }
    return false;
  }

  Future<Appuser?> getUserInfo({String? email, String? phoneNo}) async {
    final uid = _auth.currentUser?.uid;

    try {
      final snap = await _db.doc('users/$uid').get();
      if (!snap.exists) return null;
      return Appuser.fromMap(snap.data()!);
    } catch (e) {
      debugPrint('Error at User Repo findUserByEmail: $e');
      throw UserException('Something went wrong');
    }
  }
}

class UserException {
  final String message;

  UserException(
    this.message,
  );
}
