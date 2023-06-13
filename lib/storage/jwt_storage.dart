import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/login_model.dart';


class jwtStorageService{
  late final FlutterSecureStorage _preferences;

  jwtStorageService(){
    _preferences = FlutterSecureStorage();
  }

  Future<void> saveJwtData(LoginModel loginModel)async{

    await _preferences.write(key: 'jwt', value: loginModel.jwt);
  }
  Future<String> getJwtData()async{
    var _key = await _preferences.read(key: 'jwt');
    return _key ?? '';
  }
}

/* 
import 'package:localstorage/localstorage.dart';

class JwtStorageService {
  late final LocalStorage _storage;
  static const String _storageKey = 'jwt';

  JwtStorageService() {
    _storage = LocalStorage('jwt_storage');
  }

  Future<void> saveJwtData(String jwt) async {
    await _storage.ready;
    _storage.setItem(_storageKey, jwt);
  }

  Future<String?> getJwtData() async {
    await _storage.ready;
    var key = _storage.getItem(_storageKey);
    return key;
  }
} */