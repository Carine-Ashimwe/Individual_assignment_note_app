import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../repositories/auth_repository.dart';

enum AuthState { initial, loading, authenticated, unauthenticated, error }

class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();

  AuthState _state = AuthState.initial;
  User? _user;
  String? _errorMessage;

  AuthState get state => _state;
  User? get user => _user;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _user != null;

  AuthProvider() {
    _authRepository.authStateChanges.listen((user) {
      _user = user;
      if (user != null) {
        _state = AuthState.authenticated;
      } else {
        _state = AuthState.unauthenticated;
      }
      notifyListeners();
    });
  }

  Future<bool> signIn(String email, String password) async {
    _state = AuthState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authRepository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _state = AuthState.authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      _state = AuthState.error;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> signUp(String email, String password) async {
    _state = AuthState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authRepository.signUpWithEmailAndPassword(
        email: email,
        password: password,
      );
      _state = AuthState.authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      _state = AuthState.error;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    _state = AuthState.loading;
    notifyListeners();

    await _authRepository.signOut();
    _user = null;
    _state = AuthState.unauthenticated;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
