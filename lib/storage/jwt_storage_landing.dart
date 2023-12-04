
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/login_model.dart';

class jwtStorageLandingService{
  late final FlutterSecureStorage _preferences;

  jwtStorageLandingService(){
    _preferences = FlutterSecureStorage();
  }

  Future<void> saveJwtData(LoginModel loginModel)async{

    await _preferences.write(key: 'jwtLanding', value: loginModel.jwt);
  }
  Future<String> getJwtData()async{
    var _key = await _preferences.read(key: 'jwtLanding');
    return _key ?? '';
  }
  Future<void> deleteJwtData() async {
    await _preferences.delete(key: 'jwtLanding');
  }
  
}