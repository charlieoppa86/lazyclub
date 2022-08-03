// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:lazyclub/models/custom_error_model.dart';

enum SignInStatus {
  initial,
  submitting,
  success,
  error,
}

class SignInState extends Equatable {
  final SignInStatus signInStatus;
  final CustomError error;
  SignInState({
    required this.signInStatus,
    required this.error,
  });

  factory SignInState.initial() {
    return SignInState(
      signInStatus: SignInStatus.initial,
      error: CustomError(),
    );
  }

  @override
  List<Object> get props => [signInStatus, error];

  @override
  bool get stringify => true;

  SignInState copyWith({
    SignInStatus? signInStatus,
    CustomError? error,
  }) {
    return SignInState(
      signInStatus: signInStatus ?? this.signInStatus,
      error: error ?? this.error,
    );
  }
}
