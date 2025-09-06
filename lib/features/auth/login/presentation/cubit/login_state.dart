// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_cubit.dart';

/// [LoginErrorMessage] is a type alias for [String] that is used to indicate
/// error message, that will be shown to user, when he will try to submit login
/// form, but there is an error occurred. It is used to show user, what exactly
/// went wrong.
typedef LoginErrorMessage = String;

/// [LoginState] submission status, indicating current state of user login
/// process.
enum LoginStatus {
  /// [LoginStatus.idle] indicates that user has not yet submitted
  /// login form.
  idle,

  /// [LoginStatus.loading] indicates that user has submitted
  /// login form and is currently waiting for response from backend.
  loading,

  /// [LoginStatus.googleAuthInProgress] indicates that user has
  /// submitted login with google.
  googleAuthInProgress,

  /// [LoginStatus.githubAuthInProgress] indicates that user has
  /// submitted login with github.
  githubAuthInProgress,

  /// [LoginStatus.success] indicates that user has successfully
  /// submitted login form and is currently waiting for response from backend.
  success,

  /// [LoginStatus.invalidCredentials] indicates that user has
  /// submitted login form with invalid credentials.
  invalidCredentials,

  /// [LoginStatus.userNotFound] indicates that user with provided
  /// credentials was not found in database.
  userNotFound,

  /// [LoginStatus.loading] indicates that user has no internet
  /// connection,during network request.
  networkError,

  /// [LoginStatus.error] indicates that something unexpected happen.
  error,

  /// [LoginStatus.googleLogInFailure] indicates that some went
  /// wrong during google login process.
  googleLogInFailure;

  bool get isSuccess => this == LoginStatus.success;
  bool get isLoading => this == LoginStatus.loading;
  bool get isGoogleAuthInProgress => this == LoginStatus.googleAuthInProgress;
  bool get isGithubAuthInProgress => this == LoginStatus.githubAuthInProgress;
  bool get isInvalidCredentials => this == LoginStatus.invalidCredentials;
  bool get isNetworkError => this == LoginStatus.networkError;
  bool get isUserNotFound => this == LoginStatus.userNotFound;
  bool get isError =>
      this == LoginStatus.error ||
      isUserNotFound ||
      isNetworkError ||
      isInvalidCredentials;
}

class LoginState extends Equatable {
  const LoginState._({
    required this.email,
    required this.password,
    required this.showPassword,
    required this.status,
    required this.isPasswordLogin,
    required this.rememberMe,
    required this.user,
    required this.message,
    required this.hasBiometric,
    required this.hasBiometricCapability,
  });

  const LoginState.initial()
      : this._(
          email: const Email.pure(),
          password: const Password.pure(),
          showPassword: false,
          status: LoginStatus.idle,
          isPasswordLogin: true, // Default to password tab
          rememberMe: false,
          user: null,
          message: '',
          hasBiometric: false,
          hasBiometricCapability: false,
        );

  final LoginStatus status;
  final Email email;
  final Password password;
  final bool showPassword;
  final bool isPasswordLogin;
  final bool rememberMe;
  final String message;
  final AppUser? user;
  final bool hasBiometric;
  final bool hasBiometricCapability;

  @override
  List<Object?> get props => [
        status,
        email,
        password,
        showPassword,
        isPasswordLogin,
        rememberMe,
        user,
        message,
        hasBiometric,
        hasBiometricCapability,
      ];

       // Convenience getter
  bool get shouldDefaultToBiometric =>
      hasBiometricCapability && hasBiometric;

  LoginState copyWith({
    LoginStatus? status,
    Email? email,
    Password? password,
    bool? showPassword,
    bool? isPasswordLogin,
    bool? rememberMe,
    String? message,
    AppUser? user,
    bool? hasBiometric,
    bool? hasBiometricCapability,
  }) {
    return LoginState._(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      showPassword: showPassword ?? this.showPassword,
      isPasswordLogin: isPasswordLogin ?? this.isPasswordLogin,
      rememberMe: rememberMe ?? this.rememberMe,
      message: message ?? this.message,
      user: user ?? this.user,
      hasBiometric: hasBiometric ?? this.hasBiometric,
      hasBiometricCapability:
          hasBiometricCapability ?? this.hasBiometricCapability,
    );
  }
}

final loginStatusMessage = <LoginStatus, SubmissionStatusMessage>{
  LoginStatus.error: const SubmissionStatusMessage.genericError(),
  LoginStatus.networkError: const SubmissionStatusMessage.networkError(),
  LoginStatus.invalidCredentials: const SubmissionStatusMessage(
    title: 'Email and/or password are incorrect.',
  ),
  LoginStatus.userNotFound: const SubmissionStatusMessage(
    title: 'User with this email not found!',
    description: 'Try to sign up.',
  ),
  LoginStatus.googleLogInFailure: const SubmissionStatusMessage(
    title: 'Google login failed!',
    description: 'Try again later.',
  ),
};
