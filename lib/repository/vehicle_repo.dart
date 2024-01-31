import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:gostar/core/services/storage_service.dart';

class VehicleRepo {
  FirebaseAuth _auth;
  FirebaseFirestore _db;

  VehicleRepo(this._auth, this._db);

  uid() => _auth.currentUser!.uid;

  saveVehicleInfo(
    String type,
    String brand,
    String model,
    String plateNo,
    String registrationNo,
    String carFrontImg,
    String carBackImg,
  ) async {
    print('carFront: $carFrontImg');
    print('carBack: $carFrontImg');
    final [carFrontImgURL, carBackImgURL] = await Future.wait([
      StorageService.uploadPic('drivers/${uid()}/$plateNo', carFrontImg),
      StorageService.uploadPic('drivers/${uid()}/$plateNo', carBackImg),
    ]);

    try {
      await _db.doc('drivers/${uid()}/vehicles/$plateNo').set({
        'type': type,
        'brand': brand,
        'model': model,
        'plateNo': plateNo,
        'registrationNo': registrationNo,
        'carFrontImg': carFrontImgURL,
        'carBackImg': carBackImgURL,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint('Error: $e');
      throw 'Something went wrong';
    }
  }

  saveVehicleDocuments(List<Map<String, dynamic>> documents, String vid) async {
    final updatedDocuments = await Future.wait(documents.map((e) async {
      final downloadURL = await StorageService.uploadPic(
        'drivers/${uid()}/$vid',
        e['path'],
      );

      return Map.from({
        'name': e['name'],
        'path': downloadURL,
      });
    }));

    try {
      await _db
          .doc('drivers/${uid()}/vehicles/$vid')
          .update({'documents': updatedDocuments});
    } catch (e) {
      debugPrint('Error: $e');
      throw 'Something went wrong';
    }
  }
}
