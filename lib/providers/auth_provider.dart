import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gostar/core/constants.dart';
import 'package:gostar/core/services/storage_service.dart';
import 'package:gostar/models/app_user.dart';
import 'package:profanity_filter/profanity_filter.dart';

import '../repository/auth_repo.dart';
import '../core/utils/state_handler.dart';
import '../repository/user_repo.dart';

class AuthenticationProvider extends StateHandler {
  final AuthRepo _authRepo;
  final UserRepo _userRepo;
  final FirebaseAuth _auth;

  AuthenticationProvider(this._authRepo, this._userRepo, this._auth);

  String? phoneNo;
  String? forField;

  sendCode(String mobileNo, Function navigate) async {
    try {
      phoneNo = mobileNo;
      handleLoading();
      await _authRepo.sendOTP(
        phoneNo: mobileNo,
        onSuccess: (vid) {
          handleLoaded();
          navigate(vid);
        },
        onError: (e) => handleError(e),
      );
      forField = null;
    } on AuthException catch (e) {
      forField = e.forField;
      handleError(e.message);
    } catch (e) {
      handleError('Something went wrong');
    }
  }

  verifyCode(
    BuildContext context,
    String otp,
    String vid,
  ) async {
    try {
      handleLoading();
      await _authRepo.verifyOTP(otp, vid);
      final exists = await _userRepo.doesUserhasAccount(phoneNo: phoneNo);

      handleLoaded();
      forField = null;
      scheduleMicrotask(() {
        context.pushReplacement(exists ? '/tabs' : '/create-account');
      });
    } on AuthException catch (e) {
      forField = e.forField;
      handleError(e.message);
    } catch (e) {
      handleError('Something went wrong');
    }
  }

  Future<void> signUp(
    String email,
    String name,
    String city,
    String imgPath,
  ) async {
    try {
      handleLoading();

      if (_containsBadWords(name)) {
        throw AuthException('Contains bad words', forField: 'name');
      }

      final uid = _auth.currentUser!.uid;

      String downloadURL = DEFAULT_PROFILE_PIC_NETWORK;

      if (!imgPath.contains('assets/images')) {
        downloadURL = await StorageService.uploadPic('drivers/$uid', imgPath);
      }

      await _userRepo.registerDriver(
        uid,
        phoneNo!,
        email,
        name,
        city,
        downloadURL,
      );
      handleSuccess();
    } on AuthException catch (e) {
      forField = e.forField;
      handleError(e.message);
    } catch (e) {
      handleError('Something went wrong');
    }
  }

  _containsBadWords(String value) {
    final filter = ProfanityFilter();
    return filter.hasProfanity(value);
  }

  resetErrorField() {
    forField = null;
  }
}
