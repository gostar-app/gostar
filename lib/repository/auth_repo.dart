import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final FirebaseAuth _auth;
  final SharedPreferences _prefs;

  const AuthRepo(this._auth, this._prefs);

  Future<void> sendOTP({
    required String phoneNo,
    required Function onSuccess,
    required Function onError,
  }) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          debugPrint(e.toString());
          if (e.code == 'invalid-phone-number') {
            onError('Please enter an valid phone number');
          } else {
            onError('Error while sending code to $phoneNo');
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          onSuccess(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      debugPrint('Error: $e');
      throw AuthException('Error while sending an OTP');
    }
  }

  Future<void> verifyOTP(String otp, String vid) async {
    try {
      PhoneAuthCredential credential =
          PhoneAuthProvider.credential(verificationId: vid, smsCode: otp);

      await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        throw AuthException(
          'Invalid code, please check and enter correct verification code',
        );
      }
      rethrow;
    } catch (e) {
      debugPrint('Error: $e');
      throw AuthException('Error while verifying OTP');
    }
  }
}

class AuthException {
  final String message;
  final String? forField;

  AuthException(
    this.message, {
    this.forField,
  });
}
