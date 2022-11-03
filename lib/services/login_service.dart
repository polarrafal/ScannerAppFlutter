import 'dart:math';

class LoginService {
  Future<bool> logUserInAsync(String userId, String password) async {
    // Todo: login user logic
    var randomValue = Random().nextInt(2);
    if (randomValue == 1) {
      return true;
    } else {
      return false;
    }
  }
}
