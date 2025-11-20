// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'register_cubit.dart';

/// Message that will be shown to user, when he will try to submit signup form,
/// but there is an error occurred. It is used to show user, what exactly went
/// wrong.
typedef SingUpErrorMessage = String;

/// Defines possible signup submission statuses. It is used to manipulate with
/// state, using Bloc, according to state. Therefore, when [success] we
/// can simply navigate user to main page and such.
enum RegisterStatus {
  /// [RegisterStatus.idle] indicates that user has not yet submitted
  /// signup form.
  idle,

  /// [RegisterStatus.inProgress] indicates that user has submitted
  /// signup form and is currently waiting for response from backend.
  inProgress,

  /// [RegisterStatus.success] indicates that user has successfully
  /// submitted signup form and is currently waiting for response from backend.
  success,

  /// [RegisterStatus.emailAlreadyRegistered] indicates that email,
  /// provided by user, is occupied by another one in database.
  emailAlreadyRegistered,

  /// [RegisterStatus.inProgress] indicates that user had no internet
  /// connection during network request.
  networkError,

  /// [RegisterStatus.error] indicates something went wrong when user
  /// tried to sign up.
  error;

  bool get isSuccess => this == RegisterStatus.success;
  bool get isLoading => this == RegisterStatus.inProgress;
  bool get isEmailRegistered => this == RegisterStatus.emailAlreadyRegistered;
  bool get isNetworkError => this == RegisterStatus.networkError;
  bool get isError =>
      this == RegisterStatus.error || isNetworkError || isEmailRegistered;
}

@immutable
class RegisterState extends Equatable {
  const RegisterState._({
    required this.status,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.errorMessage,
    required this.showPassword,
    required this.showConfirmPassword,
    required this.confirmPassword,
    required this.confirmPasswordError,
    required this.agreedToTermsAndCondition,
    required this.basicSignup,
    required this.phone,
    required this.referral,
    required this.user,
  });

  const RegisterState.initial()
    : this._(
        status: RegisterStatus.idle,
        firstName: const FirstName.pure(),
        lastName: const LastName.pure(),
        email: const Email.pure(),
        password: const Password.pure(),
        confirmPassword: const Password.pure(),
        confirmPasswordError: '',
        phone: const Phone.pure(),
        referral: const Referral.pure(),
        errorMessage: '',
        showPassword: false,
        showConfirmPassword: false,
        agreedToTermsAndCondition: false,
        basicSignup: true,
        user:  AppUser.anonymous,
      );

  final RegisterStatus status;
  final FirstName firstName;
  final LastName lastName;
  final Email email;
  final Password password;
  final Password confirmPassword;
  final String confirmPasswordError;
  final Phone phone;
  final Referral referral;
  final String errorMessage;
  final bool showPassword;
  final bool showConfirmPassword;

  final bool agreedToTermsAndCondition;
  final bool basicSignup;
  final AppUser user;

  RegisterState copyWith({
    RegisterStatus? status,
    FirstName? firstName,
    LastName? lastName,
    Email? email,
    Password? password,
    Password? confirmPassword,
    String? confirmPasswordError,
    Phone? phone,
    Referral? referral,
    String? errorMessage,
    bool? showPassword,
    bool? showConfirmPassword,
    bool? agreedToTermsAndCondition,
    bool? basicSignup,
    AppUser? user,
  }) {
    return RegisterState._(
      status: status ?? this.status,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      confirmPasswordError:
          confirmPasswordError ?? this.confirmPasswordError,
      phone: phone ?? this.phone,
      errorMessage: errorMessage ?? this.errorMessage,
      showPassword: showPassword ?? this.showPassword,
      showConfirmPassword: showConfirmPassword ?? this.showConfirmPassword,
      agreedToTermsAndCondition:
          agreedToTermsAndCondition ?? this.agreedToTermsAndCondition,
      basicSignup: basicSignup ?? this.basicSignup,
      user: user ?? this.user,
      referral: referral ?? this.referral,
    );
  }

  @override
  List<Object?> get props => [
    password,
    confirmPassword,
    confirmPasswordError,
    email,
    status,
    errorMessage,
    phone,
    showPassword,
    showConfirmPassword,
    firstName,
    lastName,
    agreedToTermsAndCondition,
    basicSignup,
    referral,
  ];
}

final registerStatusMessage = <RegisterStatus, SubmissionStatusMessage>{
  RegisterStatus.emailAlreadyRegistered: const SubmissionStatusMessage(
    title: 'User with this email already exists.',
    description: 'Try another email address.',
  ),
  RegisterStatus.error: const SubmissionStatusMessage.genericError(),
  RegisterStatus.networkError: const SubmissionStatusMessage.networkError(),
};
