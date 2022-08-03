import 'package:flutter/material.dart';
import 'package:lazyclub/components/providers/signin/sign_in_state.dart';
import 'package:lazyclub/models/custom_error_model.dart';
import 'package:lazyclub/repositories/auth_repository.dart';

class SignInProvider with ChangeNotifier {
  SignInState _state = SignInState.initial();
  SignInState get state => _state;

  final AuthRepository authRepository;
  SignInProvider({
    required this.authRepository,
  });

  Future<void> signin({
    required String email,
    required String password,
  }) async {
    _state = _state.copyWith(signInStatus: SignInStatus.submitting);
    notifyListeners();

    try {
      await authRepository.signin(email: email, password: password);
      _state = _state.copyWith(signInStatus: SignInStatus.success);
      notifyListeners();
    } on CustomError catch (e) {
      _state = _state.copyWith(signInStatus: SignInStatus.error, error: e);
      notifyListeners();
      rethrow;
    }
  }
}
