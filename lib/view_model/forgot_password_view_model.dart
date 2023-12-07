import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../service/authantication_service.dart';

class ForgotPasswordNotifier extends StateNotifier<Map<String, dynamic>> {
  ForgotPasswordNotifier() : super({});

  Response? response;


  Future<void> forgotPassword({String? email}) async {
    final autService = AuthenticationService();
    Map<String, dynamic> _forgotPasswordData = {    
      "password": {
        "email": email
      }
    };

    try {
      response = await autService.forgotPassword(forgotPasswordData: _forgotPasswordData);
      Map<String, dynamic> responseData = jsonDecode(response.toString());
      
      state = responseData;
    } catch (e) {
      rethrow;
    }
  }
}

final forgotPasswordProvider =StateNotifierProvider<ForgotPasswordNotifier, Map<String, dynamic>>((ref) => ForgotPasswordNotifier());

