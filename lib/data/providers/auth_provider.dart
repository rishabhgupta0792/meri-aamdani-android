import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthState {
  final String? phoneNumber;
  final bool isVerified;
  final String? selectedBank;
  final String? language;

  AuthState({
    this.phoneNumber,
    this.isVerified = false,
    this.selectedBank,
    this.language,
  });

  AuthState copyWith({
    String? phoneNumber,
    bool? isVerified,
    String? selectedBank,
    String? language,
  }) {
    return AuthState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isVerified: isVerified ?? this.isVerified,
      selectedBank: selectedBank ?? this.selectedBank,
      language: language ?? this.language,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState());

  void setLanguage(String lang) {
    state = state.copyWith(language: lang);
  }

  void login(String phone) {
    state = state.copyWith(phoneNumber: phone);
  }

  void verifyAadhaar() {
    state = state.copyWith(isVerified: true);
  }

  void selectBank(String bank) {
    state = state.copyWith(selectedBank: bank);
  }

  void logout() {
    state = AuthState();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
