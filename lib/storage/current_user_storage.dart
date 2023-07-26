import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/web_content_model.dart';


class CompanyIdStorageLandingService{
  late final FlutterSecureStorage _preferences;

  CompanyIdStorageLandingService(){
    _preferences = FlutterSecureStorage();
  }

  Future<void> saveCompanyIdData(WebContentModel webContentData)async{

    await _preferences.write(key: 'company_id', value: webContentData.companyId.toString());
  }
  Future<String> getCompanyIdData()async{
    var _key = await _preferences.read(key: 'company_id');
    return _key ?? '';
  }
  Future<void> deleteCompanyIdData() async {
    await _preferences.delete(key: 'company_id');
  }
  
}