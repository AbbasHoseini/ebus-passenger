
import 'package:ebus/core/models/User.dart';

class LoginViewModelOld {

  final User? login;

  LoginViewModelOld({this.login});

  String? get token {
    return login!.token;
  }

  String? get name {
    return login!.name;
  }

  String? get status {
    return login!.status;
  }

  bool get loggedIn {
    if(login!.status!.contains("ok"))
      return true;
    return false;
  }

}