import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/domain/entities/user.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';
import 'package:teslo_shop/features/auth/infrastructure/repositories/auth_repository_impl.dart';

// provider initial for AuthNotifier
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();
  
  return AuthNotifier(
    authRepository: authRepository,
  );
});

class AuthNotifier extends StateNotifier<AuthState> {

  final AuthRepository authRepository;
  AuthNotifier({ required this.authRepository}): super(AuthState()); // state initial 

  void loginUSer (String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try{
      final user = await authRepository.login(email, password);
      _setLoggedUser (user);
    } on WrongCredentials {
      logout('Credentials are wrong');
    }
    catch (e) {
      logout('Erorr not controlled');
    }

    // call repository
    // final user = await _authRepository.login(email, password);
    // state = state.copyWith(authStatus: AuthStatus.authenticated, user: user);
  }
  void registerUser (String email, String password, String fullName) async {
    // call repository
    // final user = await _authRepository.register(email, password, fullName);
    // state = state.copyWith(authStatus: AuthStatus.authenticated, user: user);
  }

  void checkAuthStatus (String token) async {
    // call repository
    // final user = await _authRepository.checkAuthStatus(token);
    // state = state.copyWith(authStatus: AuthStatus.authenticated, user: user);
  }

   Future <void> logout([String? errorMessage]) async {
    // TODO:clean token
    state = state.copyWith(
    authStatus: AuthStatus.notAuthenticated, 
    user: null, 
    errorMessage: errorMessage);

    // call repository
    // await _authRepository.logout();
    // state = state.copyWith(authStatus: AuthStatus.notAuthenticated, user: null);
  }

  void _setLoggedUser(User user) {
    // TODO: save the token
    state = state.copyWith(
      authStatus: AuthStatus.authenticated, 
      user: user,
      errorMessage: '',
      );
  }
}

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String? errorMessage;

  AuthState(
      {this.authStatus = AuthStatus.checking,
      this.user,
      this.errorMessage = ''});

  AuthState copyWith(
      {AuthStatus? authStatus, User? user, String? errorMessage}) {
    return AuthState(
        authStatus: authStatus ?? this.authStatus,
        user: user ?? this.user,
        errorMessage: errorMessage ?? this.errorMessage);
  }

 
}
