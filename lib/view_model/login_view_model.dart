import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/login_model.dart';
import '../service/login_service.dart';


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
    state = LoginState.loading;
    try {
      _loginModel = await loginCall(email: email, password: password);
      if (_loginModel!.status == 200) {
        debugPrint(_loginModel!.status.toString());
        state = LoginState.success;
        debugPrint(state.toString());
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


/* 
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/login_model.dart';
import '../service/login_service.dart';
import '../storage/jwt_storage.dart';

enum LoginState {
  initial,
  loading,
  success,
  failure,
}

class LoginViewModel extends StateNotifier<LoginState> {
  final JwtStorageService _jwtStorageService = JwtStorageService();

  LoginViewModel() : super(LoginState.initial);

  LoginModel? loginModel;

  Future<void> login({required String email, required String password}) async {
    state = LoginState.loading;
    try {
      loginModel = await loginCall(email: email, password: password);
      if (loginModel!.status.toString() == "200") {
        debugPrint(loginModel!.status.toString());
        if (loginModel!.jwt != null) {
          await _jwtStorageService.saveJwtData(loginModel!.jwt!);
        }
        state = LoginState.success;
        debugPrint(state.toString());
      }
    } catch (e) {
      state = LoginState.failure;
      throw e;
    }
  }
}

final loginViewModelProvider = StateNotifierProvider<LoginViewModel, LoginState>((ref) => LoginViewModel());

final stringProvider = StateProvider<String>((ref) => ''); */