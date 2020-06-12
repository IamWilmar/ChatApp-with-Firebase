import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();
  factory PreferenciasUsuario() {
    return _instancia;
  }
  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  get isUserLogged {
    return _prefs.getBool('isUserLogged') ?? false;
  }

  set isUserLogged(bool val) {
    _prefs.setBool('isUserLogged', val);
  }

  //-----------------------------------------
  get userName {
    return _prefs.getString('userName') ?? '';
  }

  set userName(String username) {
    _prefs.setString('userName', username);
  }

  //---------------------------------------------
  get userEmail {
    return _prefs.getString('userEmail') ?? '';
  }

  set userEmail(String userEmail) {
    _prefs.setString('userEmail', userEmail);
  }
  //---------------------------------------------
  get userPassword {
    return _prefs.getString('userPassword') ?? '';
  }

  set userPassword(String userPassword) {
    _prefs.setString('userPassword', userPassword);
  }
}
