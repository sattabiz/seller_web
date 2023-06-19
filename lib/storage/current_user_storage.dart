import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

Future<void> saveName(name)async{
    await _storage.write(key: 'name', value: name);
  }
  Future<String> getNameData()async{
    var _key = await _storage.read(key: 'name');
    return _key ?? '';
  }

  Future<void> saveFullName(fullname)async{
    await _storage.write(key: 'fullname', value: fullname);
  }
  Future<String> getFullNameData()async{
    var _key = await _storage.read(key: 'fullname');
    return _key ?? '';
  }

}
