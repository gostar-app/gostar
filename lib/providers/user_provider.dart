import 'package:gostar/core/utils/state_handler.dart';
import 'package:gostar/models/app_user.dart';
import 'package:gostar/repository/user_repo.dart';

class UserProvider extends StateHandler {
  final UserRepo _userRepo;

  UserProvider(this._userRepo);

  Appuser? user;

  getUserInfo() async {
    user = await _userRepo.getUserInfo();
    return user;
  }
}
