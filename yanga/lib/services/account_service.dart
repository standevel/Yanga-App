import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yanga/api_response.dart';
import 'package:yanga/constants.dart';
import 'package:yanga/routes.dart';
import 'package:yanga/services/api_service.dart';

class AccountService {
  var accountUrl = 'accounts';
  final Dio _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {'Content-Type': 'application/json'},
  ));

  Future<void> signUp(
      String email, String password, String name, String role) async {
    ApiService apiService = ApiService(baseUrl: baseUrl);
    print('sign up called');
    try {
      print('email: $email pwd: $password');

      YangaApiResponse<Map<String, dynamic>> response =
          await apiService.makeRequest(
        accountUrl,
        (json) => json as Map<String, dynamic>, // Generic JSON parsing
        method: "POST",
        body: {
          "email": email,
          "password": password,
          "name": name,
          "role": role,
          "phoneNumber": 'Nil'
        },
      );
      print('response $response');
      if (response.status) {
        print("Signup Successful: ${response.data}");
        // await saveToken(response.data!['accessToken']);
        showToastMessage(response.message,
            color: Colors.red, backgroundColor: Colors.white);
        SharedPreferences.getInstance()
            .then((ref) => {ref.setBool('goToLogin', true)});
        QR.toName(AppRoutes.verifyEmailRoute);
      } else {
        print("Signup Failed: ${response.message}");
        showToastMessage(response.message,
            color: Colors.red, backgroundColor: Colors.white);
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> login(Map<String, dynamic> signInForm) async {
    ApiService apiService = ApiService(baseUrl: baseUrl);
    print('signinForm: $signInForm');
    try {
      YangaApiResponse<Map<String, dynamic>> response =
          await apiService.makeRequest("$accountUrl/signin",
              (json) => json as Map<String, dynamic>, // Generic JSON parsing
              method: "POST",
              body: signInForm //{"email": email, "password": password},
              );

      if (response.status) {
        print("Login Successful: ${response.data}");
        await saveToken(response.data!['accessToken']);
        showToastMessage(response.message,
            color: Colors.red, backgroundColor: Colors.white);
        QR.toName(AppRoutes.homeRoute);
      } else {
        print("Login Failed: ${response.message}");
        if (response.message.contains('verify')) {
          print('message contains verify');
          SharedPreferences.getInstance()
              .then((ref) => {ref.setBool('goToLogin', true)});
          QR.toName(AppRoutes.verifyEmailRoute);
        }
        // if (response.statusCode == 400) {
        //   showToastMessage('Invalid credentials',
        //       color: Colors.red, backgroundColor: Colors.white);
        // }
      }
      showToastMessage(response.message,
          color: Colors.red, backgroundColor: Colors.white);
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> saveToken(String token) async {
    print('saving token: $token');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    await prefs.setBool('isLoggedIn', true);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  Future<YangaApiResponse<dynamic>> verifyemail(
      String email, String token) async {
    ApiService apiService = ApiService(baseUrl: baseUrl);

    var url = Uri.parse('${baseUrl}accounts/verify-email');
    print('url: $url');
    final jsonBody = {"email": email, "token": token};
    print('jsonBody: $jsonBody');
    YangaApiResponse<Map<String, dynamic>> response =
        await apiService.makeRequest(
      'accounts/verify-email',
      method: 'POST',
      (json) => json as Map<String, dynamic>,
      body: jsonBody,
    );
    // final responseBody = jsonDecode(re);
    print('response body: $response');
    final message = response.message;
    if (response.status) {
      showToastMessage(message, color: Colors.green);
      return response;
    } else {
      showToastMessage(message, color: Colors.red);
      return response;
    }
  }
}
