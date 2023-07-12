import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../service/authantication_service.dart';


enum LogoutState {
  initial,
  loggingOut,
  success,
  failure,
}

class LogoutViewModel extends StateNotifier<LogoutState> {
  LogoutViewModel() : super(LogoutState.initial);

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<void> logout() async {
    final authService = AuthenticationService();
    state = LogoutState.loggingOut;
    try {
      await authService.logout();
      state = LogoutState.success;
    } catch (e) {
      state = LogoutState.failure;
      _errorMessage = e.toString();
    }
  }
}

final logoutViewModelProvider =
    StateNotifierProvider<LogoutViewModel, LogoutState>(
        (ref) => LogoutViewModel());