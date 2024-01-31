import 'package:gostar/core/utils/state_handler.dart';
import 'package:gostar/repository/vehicle_repo.dart';

class VehicleProvider extends StateHandler {
  final VehicleRepo _vehicleRepo;

  VehicleProvider(this._vehicleRepo);

  String? vid;

  saveVehicleInfo(
    String type,
    String brand,
    String model,
    String plateNo,
    String registrationNo,
    String carFrontImg,
    String carBackImg,
  ) async {
    handleLoading();
    vid = plateNo;
    await asyncHandler(
      _vehicleRepo.saveVehicleInfo(
        type,
        brand,
        model,
        plateNo,
        registrationNo,
        carFrontImg,
        carBackImg,
      ),
      afterState: ProviderState.success,
    );
  }

  saveVehicleDocuments(
    List<Map<String, dynamic>> documents,
  ) async {
    handleLoading();
    if (vid != null) {
      await asyncHandler(
        _vehicleRepo.saveVehicleDocuments(
          documents,
          vid!,
        ),
        afterState: ProviderState.success,
      );
    }
  }
}
