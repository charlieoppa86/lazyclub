import 'package:flutter/material.dart';
import 'package:lazyclub/components/providers/signup/sign_up_state.dart';
import 'package:lazyclub/models/custom_error_model.dart';
import 'package:lazyclub/repositories/auth_repository.dart';

class SignUpProvider with ChangeNotifier {
  SignUpState _state = SignUpState.initial();
  SignUpState get state => _state;

  final AuthRepository authRepository;
  SignUpProvider({
    required this.authRepository,
  });

  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    _state = _state.copyWith(signUpStatus: SignUpStatus.submitting);
    notifyListeners();

    try {
      await authRepository.signup(name: name, email: email, password: password);
      _state = _state.copyWith(signUpStatus: SignUpStatus.success);
      notifyListeners();
    } on CustomError catch (e) {
      _state = _state.copyWith(signUpStatus: SignUpStatus.error, error: e);
      notifyListeners();
      rethrow;
    }
  }
}
