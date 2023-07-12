
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/login_model.dart';
import '../service/authantication_service.dart';

enum LoginState {
  //bu sonra utils/login_states e alinacak
  initial,
  loading,
  success,
  failure,
}

class LoginViewModel extends StateNotifier<LoginState> {
  LoginViewModel() : super(LoginState.initial);

  LoginModel? _loginModel;
  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<void> login({required String email, required String password}) async {
    final autService = AuthenticationService();
    state = LoginState.loading;
    try {
      _loginModel = await autService.loginCall(email: email, password: password);
      if (_loginModel!.status == 200) {
        state = LoginState.success;;
      } else {
        state = LoginState.failure;
        _errorMessage = 'Hatalı durum kodu: ${_loginModel!.status}';
      }
    } catch (e) {
      state = LoginState.failure;
      _errorMessage = e.toString();
    }
  }
}

final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, LoginState>(
        (ref) => LoginViewModel());

