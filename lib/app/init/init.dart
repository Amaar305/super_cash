import 'dart:async';

import 'package:app_client/app_client.dart';
import 'package:super_cash/app/bloc/app_bloc.dart';
import 'package:super_cash/app/cubit/app_cubit.dart';
import 'package:super_cash/core/cooldown/cooldown_repository.dart';
import 'package:super_cash/core/cooldown/cubit/cooldown_cubit.dart';
import 'package:super_cash/core/device/device.dart';
import 'package:super_cash/core/error/api_error_handle.dart';
import 'package:super_cash/core/network/network_info.dart';
import 'package:super_cash/features/account/manage_transaction_pin/manage_transaction_pin.dart';
import 'package:super_cash/features/auth/referral_type/referral_type.dart';
import 'package:super_cash/features/bonus/bonus.dart';
import 'package:super_cash/features/card/card.dart';
import 'package:super_cash/features/card/card_repo/cubit/card_repo_cubit.dart';
import 'package:super_cash/features/confirm_transaction_pin/confirm_transaction_pin.dart';
import 'package:super_cash/features/history/history.dart';
import 'package:super_cash/features/live_chat/live_chat.dart';
import 'package:super_cash/features/notification/notification.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_cash/features/referal/referal.dart';
import 'package:token_repository/token_repository.dart';
import 'package:http/http.dart' as http;

import '../../features/add_fund/add_fund.dart';
import '../../features/auth/auth.dart';
import '../../features/card/card_details/domain/use_cases/card_details_use_cases.dart';
import '../../features/card/card_repo/card_repo.dart';
import '../../features/home/home.dart';
import '../../features/upgrade_tier/upgrade_tier.dart';
import '../../features/vtupass/vtupass.dart';

GetIt serviceLocator = GetIt.instance;

const _fingerprintInitKey = 'fingerprint_initialized_v1';
Future<void> _initFingerprint(SharedPreferences storage) async {
  final fingerprint = Fingerprint(storage: storage);
  if (!serviceLocator.isRegistered<Fingerprint>()) {
    serviceLocator.registerSingleton<Fingerprint>(fingerprint);
  }

  final initialized = storage.getBool(_fingerprintInitKey) ?? false;
  if (!initialized) {
    await fingerprint.collect();
    await storage.setBool(_fingerprintInitKey, true);
  }
}

Future<void> initDependencies() async {
  // Init sharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();

  await _initFingerprint(sharedPreferences);

  final LocalAuthentication auth = LocalAuthentication();
  final isSupported = await auth.isDeviceSupported();

  serviceLocator
    ..registerLazySingleton<TokenRepository>(
      () => TokenRepositoryImpl(sharedPreferences),
    )
    ..registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnection()),
    )
    ..
    // Data sources
    registerLazySingleton(
      () => AuthClient(
        client: http.Client(),
        tokenRepository: serviceLocator(),
        baseUrl: 'http://167.71.92.9/api/v1',
        // baseUrl: 'http://127.0.0.1:8000/api/v1',
        // 'http://127.0.0.1:8000/api/v1',
      ),
    )
    ..registerLazySingleton<DeviceRegistrar>(
      () => DeviceRegistrar(
        authClient: serviceLocator(),
        fingerprint: serviceLocator(),
      ),
    )
    ..registerLazySingleton(() => sharedPreferences)
    ..registerFactory<LocalAuthentication>(() => auth)
    ..registerLazySingleton(() => isSupported)
    ..registerLazySingleton(
      () => AppBloc(
        tokenRepository: serviceLocator(),
        userRepository: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => AppCubit(
        tokenRepository: serviceLocator(),
        loginLocalDataSource: serviceLocator(),
        preferences: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => ApiErrorHandler(
        appBloc: serviceLocator(),
        appCubit: serviceLocator(),
      ),
    );
  unawaited(serviceLocator<DeviceRegistrar>().register(withAuth: false));
  _auth();
  _cooldown();
  _confirmTransactionPin();
  _home();
  _liveSuppors();
  _cardDollarRate();
  _airtime();
  _notifications();
  _data();
  _cable();
  _electricity();
  _upgradeAccount();
  _fetchVirtulCards();
  _cardCreation();
  _cardDetails();
  _cardFunding();
  _changeCardPin();
  _cardWithdraw();
  _appTransactions();
  _cardTransactions();
  _beneficiary();
  _addFund();
  _changeTransactionPin();
  _referralSystem();
  _referralType();
  _bonus();
}

void _liveSuppors() {
  // Datasource
  serviceLocator
    ..registerFactory<LiveChatRemoteDataSource>(
      () => LiveChatRemoteDataSourceImpl(apiClient: serviceLocator()),
    )
    // Repository
    ..registerFactory<LiveChatRepository>(
      () => LiveChatRepositoryImpl(
        liveChatRemoteDataSource: serviceLocator(),
        apiErrorHandler: serviceLocator(),
      ),
    )
    // Usecase
    ..registerFactory(
      () => FetchSupportsUseCase(liveChatRepository: serviceLocator()),
    );
}

void _referralType() {
  // DataSource
  serviceLocator
    ..registerFactory<ReferralTypeRemoteDataSource>(
      () => ReferralTypeRemoteDataSourceImpl(apiClient: serviceLocator()),
    )
    // Repository
    ..registerFactory<ReferralTypeRepository>(
      () => ReferralTypeRepositoryImpl(
        referralTypeRemoteDataSource: serviceLocator(),
        networkInfo: serviceLocator(),
      ),
    )
    // UseCases
    ..registerFactory(
      () => FetchCompainsUseCase(referralTypeRepository: serviceLocator()),
    )
    ..registerFactory(
      () => EnrolCompainUseCase(referralTypeRepository: serviceLocator()),
    );
}

void _bonus() {
  // Datasources
  serviceLocator
    ..registerFactory<BonusRemoteDataSource>(
      () => BonusRemoteDataSourceImpl(apiClient: serviceLocator()),
    )
    // Repository
    ..registerFactory<BonusRepository>(
      () => BonusRepositoryImpl(
        bonusRemoteDataSource: serviceLocator(),
        apiErrorHandler: serviceLocator(),
      ),
    )
    // Use cases
    ..registerFactory(
      () => FetchBankListUseCase(bonusRepository: serviceLocator()),
    )
    ..registerFactory(
      () => ValidateBankUseCase(bonusRepository: serviceLocator()),
    )
    ..registerFactory(() => SendMoneyUseCase(bonusRepository: serviceLocator()))
    ..registerFactory(
      () => WithdrawBonusUseCase(bonusRepository: serviceLocator()),
    );
}

void _referralSystem() {
  // DataSource
  serviceLocator
    ..registerFactory<ReferalRemoteDataSource>(
      () => ReferalRemoteDataSourceImpl(apiClient: serviceLocator()),
    )
    // Repository
    ..registerFactory<ReferalRepository>(
      () => ReferalRepositoryImpl(
        referalRemoteDataSource: serviceLocator(),
        apiErrorHandler: serviceLocator(),
      ),
    )
    // UseCases
    ..registerFactory(
      () => FetchMyReferralsUseCase(referalRepository: serviceLocator()),
    )
    ..registerFactory(
      () => ClaimMyRewardsUseCase(referalRepository: serviceLocator()),
    );
}

void _changeTransactionPin() {
  // DataSource
  serviceLocator
    ..registerFactory<ChangeTransactionPinRemoteDataSource>(
      () =>
          ChangeTransactionPinRemoteDataSourceImpl(apiClient: serviceLocator()),
    )
    // Repository
    ..registerFactory<ChangeTransactionPinRepository>(
      () => ChangeTransactionPinRepositoryImpl(
        changeTransactionPinRemoteDataSource: serviceLocator(),
        apiErrorHandler: serviceLocator(),
      ),
    )
    // Usecase
    ..registerFactory(
      () => UpdateTransactionPinUseCase(
        changeTransactionPinRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => RequestTransactionPinOtpUseCase(
        changeTransactionPinRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => ResetTransactionPinUseCase(
        changeTransactionPinRepository: serviceLocator(),
      ),
    );
}

void _addFund() {
  // Datasources
  serviceLocator
    ..registerFactory<AddFundRemoteDataSource>(
      () =>
          AddFundRemoteDataSourceImpl(apiClient: serviceLocator<AuthClient>()),
    )
    // Repositories
    ..registerFactory<AddFundRepository>(
      () => AddFundRepositoryImpl(
        remoteDataSource: serviceLocator(),
        apiErrorHandler: serviceLocator(),
      ),
    )
    // Usecases
    ..registerFactory(
      () => GenerateAccountUseCase(
        addFundRepository: serviceLocator<AddFundRepository>(),
      ),
    );
}

void _beneficiary() {
  // Datasources
  serviceLocator
    ..registerFactory<BeneficiaryRemoteDataSource>(
      () => BeneficiaryRemoteDataSourceImpl(serviceLocator()),
    )
    // Repositories
    ..registerFactory<BeneficiaryRepositories>(
      () => BeneficiaryRepositoriesImpl(
        remoteDataSource: serviceLocator(),
        apiErrorHandler: serviceLocator(),
      ),
    )
    // Usecases
    ..registerFactory(
      () => FetchBeneficiaryUsecase(serviceLocator<BeneficiaryRepositories>()),
    )
    ..registerFactory(
      () => SaveBeneficiaryUseCase(serviceLocator<BeneficiaryRepositories>()),
    )
    ..registerFactory(
      () => UpdateBeneficiaryUseCase(serviceLocator<BeneficiaryRepositories>()),
    )
    ..registerFactory(
      () => DeleteBeneficiaryUseCase(serviceLocator<BeneficiaryRepositories>()),
    )
    // Cubit
    ..registerLazySingleton(
      () => ManageBeneficiaryCubit(
        fetchBeneficiaryUsecase: serviceLocator<FetchBeneficiaryUsecase>(),
        deleteBeneficiaryUseCase: serviceLocator<DeleteBeneficiaryUseCase>(),
      ),
    );
}

void _cardDollarRate() {
  // Database
  serviceLocator
    ..registerFactory<CardRemoteDataSource>(
      () => CardRemoteDataSourceImpl(apiClient: serviceLocator()),
    )
    // Repository
    ..registerFactory<CardRepositories>(
      () => CardRepositoryImpl(
        cardRemoteDataSource: serviceLocator(),
        apiErrorHandler: serviceLocator(),
      ),
    )
    // Usecases
    ..registerFactory(
      () => GetDollarRateUseCase(cardRepositories: serviceLocator()),
    )
    // Cubit
    ..registerLazySingleton(
      () => CardRepoCubit(getDollarRateUseCase: serviceLocator()),
    );
}

void _notifications() {
  // Databases
  serviceLocator
    ..registerFactory<NotificationRemoteDataSource>(
      () => NotificationRemoteDataSourceImpl(apiClient: serviceLocator()),
    )
    // Repository
    ..registerFactory<NotificationRepositories>(
      () => NotificationRepositoriesImpl(
        notificationRemoteDataSource: serviceLocator(),
        apiErrorHandler: serviceLocator(),
      ),
    )
    // Usecases
    ..registerFactory(
      () =>
          FetchNotificationsUseCase(notificationRepositories: serviceLocator()),
    )
    ..registerFactory(
      () =>
          UpdateNotificationUseCase(notificationRepositories: serviceLocator()),
    );
}

void _appTransactions() {
  // Database
  serviceLocator
    ..registerFactory<HistoryRemoteDataSource>(
      () =>
          HistoryRemoteDataSourceImpl(apiClient: serviceLocator<AuthClient>()),
    )
    // Repository
    ..registerFactory<HistoryRepositories>(
      () => HistoryRepositoriesImpl(
        historyRemoteDataSource: serviceLocator(),
        apiErrorHandler: serviceLocator<ApiErrorHandler>(),
        networkInfo: serviceLocator<NetworkInfo>(),
      ),
    )
    // Usecases
    ..registerFactory(
      () => FetchTransactionsUseCase(historyRepositories: serviceLocator()),
    );
}

void _cardTransactions() {
  // Databases
  serviceLocator
    ..registerFactory<CardTransactionsRemoteDataSource>(
      () => CardTransactionsRemoteDataSourceImpl(apiClient: serviceLocator()),
    )
    // Repositories
    ..registerFactory<CardTransactionsRepositories>(
      () => CardTransactionsRepositoriesImpl(
        cardTransactionsRemoteDataSource: serviceLocator(),
        apiErrorHandler: serviceLocator(),
      ),
    )
    // Usecases
    ..registerFactory(
      () => FetchCardTransactionsUseCase(
        cardTransactionRepositories: serviceLocator(),
      ),
    );
}

void _changeCardPin() {
  // Database
  serviceLocator
    ..registerFactory<ChangeCardPinRemoteDataSource>(
      () => ChangeCardPinRemoteDataSourceImpl(apiClient: serviceLocator()),
    )
    // Repository
    ..registerFactory<ChangeCardPinRepositories>(
      () => ChangeCardPinRepositoriesImpl(
        changeCardPinRemoteDataSource: serviceLocator(),
        apiErrorHandler: serviceLocator(),
      ),
    )
    // Usecase
    ..registerFactory(
      () => ChangeCardPinUseCase(changeCardPinRepositories: serviceLocator()),
    );
}

void _confirmTransactionPin() {
  // Database
  serviceLocator
    ..registerCachedFactory<ConfirmTransactionPinRemoteDataSource>(
      () => ConfirmTransactionPinRemoteDataSourceImpl(
        apiClient: serviceLocator(),
      ),
    )
    // repository
    ..registerFactory<ConfirmTransactionPinRepositories>(
      () => ConfirmTransactionPinRepositoriesImpl(
        confirmTransactionPinRemoteDataSource: serviceLocator(),
        apiErrorHandler: serviceLocator(),
      ),
    )
    // Usecase
    ..registerFactory(
      () => VerifyTransactionPinUseCase(
        confirmTransationPinRepositories: serviceLocator(),
      ),
    )
    // Cubit
    ..registerLazySingleton(
      () => ConfirmTransactionPinCubit(
        verifyTransactionPinUseCase: serviceLocator(),
      ),
    );
}

void _cardDetails() {
  // Databases
  serviceLocator
    ..registerFactory<CardDetailsRemoteDataSource>(
      () => CardDetailsRemoteDataSourceImpl(apiClient: serviceLocator()),
    )
    // Repositories
    ..registerFactory<CardDetailsRepositories>(
      () => CardDetailsRepositoriesImpl(
        cardDetailsRemoteDataSource: serviceLocator(),
        apiErrorHandler: serviceLocator(),
      ),
    )
    // UseCasess
    ..registerFactory(
      () => CardDetailsUseCase(cardDetailsRepositories: serviceLocator()),
    )
    ..registerFactory(
      () => FreezeCardUseCase(cardDetailsRepositories: serviceLocator()),
    );
}

void _cooldown() {
  // Repository
  serviceLocator
    ..registerFactory<CooldownRepository>(
      () => CooldownRepositoryImpl(prefs: serviceLocator()),
    )
    // Cubit
    ..registerLazySingleton(
      () => CooldownCubit(cooldownRepository: serviceLocator()),
    );
}

void _cardWithdraw() {
  // Databases
  serviceLocator
    ..registerFactory<CardWithdrawRemoteDataSource>(
      () => CardWithdrawRemoteDataSourceImpl(apiClient: serviceLocator()),
    )
    // Repositories
    ..registerFactory<CardWithdrawRepositories>(
      () => CardWithdrawRepositoriesImpl(
        cardWithdrawRemoteDataSource: serviceLocator(),
        apiErrorHandler: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => WithdrawFundUseCase(cardWithdrawRepositories: serviceLocator()),
    )
    ..registerFactory(
      () =>
          FetchWalletBalanceUseCase(cardWithdrawRepositories: serviceLocator()),
    );
  // Usecases
}

void _cardFunding() {
  // Database
  serviceLocator
    ..registerFactory<FundCardRemoteDataSource>(
      () => FundCardRemoteDataSourceImpl(apiClient: serviceLocator()),
    )
    // Repository
    ..registerFactory<FundCardRepositories>(
      () => FundCardRepositoriesImpl(
        fundCardRemoteDataSource: serviceLocator(),
        apiErrorHandler: serviceLocator(),
      ),
    )
    // UseCase
    ..registerFactory(
      () => FundCardUseCase(fundCardRepositories: serviceLocator()),
    );
}

void _fetchVirtulCards() {
  // Databases
  serviceLocator
    ..registerFactory<FetchVirtualCardRemoteDataSource>(
      () => FetchVirtualCardRemoteDataSourceImpl(apiClient: serviceLocator()),
    )
    // Repositories
    ..registerFactory<FetchVirtualCardRepositories>(
      () => FetchVirtualCardRepositoriesImpl(
        fetchVirtualCardRemoteDataSource: serviceLocator(),
        apiErrorHandle: serviceLocator(),
      ),
    )
    // Usecases
    ..registerFactory<FetchVirtualCardUseCase>(
      () => FetchVirtualCardUseCase(
        fetchVirtualCardRepositories: serviceLocator(),
      ),
    );
}

void _cardCreation() {
  // Database
  serviceLocator
    ..registerFactory<CreateCardRemoteDataSource>(
      () => CreateCardRemoteDataSourceImpl(apiClient: serviceLocator()),
    )
    // Repository
    ..registerFactory<CreateCardRepositories>(
      () => CreateCardRepositoriesImpl(
        createCardRemoteDataSource: serviceLocator(),
        apiErrorHandle: serviceLocator(),
      ),
    )
    // Usecases
    ..registerFactory(
      () => CreateCardUseCases(createCardRepositories: serviceLocator()),
    );
}

void _upgradeAccount() {
  // Database
  serviceLocator
    ..registerFactory<UpgradeTierRemoteDataSource>(
      () => UpgradeTierRemoteDataSourceImpl(apiClient: serviceLocator()),
    )
    // Repository
    ..registerFactory<UpgradeTierRepositories>(
      () => UpgradeTierRepositoriesImpl(
        upgradeTierRemoteDataSource: serviceLocator(),
        apiErrorHandler: serviceLocator(),
      ),
    )
    // Usecase
    ..registerFactory(
      () => UpgradeAccountUseCase(upgradeTierRepositories: serviceLocator()),
    )
    ..registerFactory(
      () =>
          CheckUpgradeStatusUseCase(upgradeTierRepositories: serviceLocator()),
    );
}

void _electricity() {
  // Datasources
  serviceLocator
    ..registerFactory<ElectricityRemoteDataSource>(
      () => ElectricityRemoteDataSourceImpl(
        authClient: serviceLocator<AuthClient>(),
      ),
    )
    // Repositories
    ..registerFactory<ElectricityRepository>(
      () => ElectricityRepositoryImpl(
        electricityRemoteDataSource:
            serviceLocator<ElectricityRemoteDataSource>(),
        apiErrorHandler: serviceLocator(),
      ),
    )
    // Usecases
    ..registerFactory(
      () => ValidateElectricityPlanUseCase(
        electricityRepository: serviceLocator<ElectricityRepository>(),
      ),
    )
    ..registerFactory(
      () => GetElectricityPlansUseCase(
        electricityRepository: serviceLocator<ElectricityRepository>(),
      ),
    )
    ..registerFactory(
      () => PurchaseElectricityPlanUseCase(
        electricityRepository: serviceLocator<ElectricityRepository>(),
      ),
    );
}

void _data() {
  // Datasources
  serviceLocator
    ..registerFactory<DataRemoteDataSource>(
      () => DataRemoteDataSourceImpl(authClient: serviceLocator<AuthClient>()),
    )
    // Repositories
    ..registerFactory<DataRepository>(
      () => DataRepositoryImpl(
        dataRemoteDataSource: serviceLocator<DataRemoteDataSource>(),
        apiErrorHandler: serviceLocator(),
      ),
    )
    // Usecases
    ..registerFactory(
      () => FetchDataPlanUseCase(repository: serviceLocator<DataRepository>()),
    )
    ..registerFactory(
      () => BuyDataPlanUseCase(repository: serviceLocator<DataRepository>()),
    );
}

void _home() {
  serviceLocator
    ..registerFactory<HomeUserRemoteDataSource>(
      () => HomeUserRemoteDataSourceImpl(authClient: serviceLocator()),
    )
    // Repositories
    ..registerFactory<HomeUserRepository>(
      () => HomeUserRepositoryImpl(
        homeUserRemoteDataSource: serviceLocator(),
        networkInfo: serviceLocator(),
        apiErrorHandler: serviceLocator(),
      ),
    )
    // Usecases
    ..registerFactory(
      () => FetchUserUseCase(homeUserRepository: serviceLocator()),
    )
    ..registerFactory(
      () => FetchAppSettingsUseCase(homeUserRepository: serviceLocator()),
    );
}

_auth() {
  _login();
  _register();
  _createTransactionPin();
  _verifyOTP();
  _forgotPassword();
}

void _verifyOTP() {
  serviceLocator
    ..registerFactory<OtpRemoteDataSoure>(
      () => OtpRemoteDataSoureImpl(apiClient: serviceLocator()),
    )
    // Repositories
    ..registerFactory<OtpRepository>(
      () => OtpRepositoryImpl(otpRemoteDataSoure: serviceLocator()),
    )
    // Usecases
    ..registerFactory(
      () => RequestVerifyOtpUseCase(otpRepository: serviceLocator()),
    )
    ..registerFactory(() => OtpUseCase(otpRepository: serviceLocator()));
}

void _forgotPassword() {
  serviceLocator
    ..registerFactory<ForgotPasswordRemoteDataSource>(
      () => ForgotPasswordRemoteDataSourceImpl(authClient: serviceLocator()),
    )
    // Repositories
    ..registerFactory<ForgotPasswordRepository>(
      () => ForgotPasswordRepositoryImpl(
        forgotPasswordRemoteDataSource: serviceLocator(),
      ),
    )
    // Usecases
    ..registerFactory(
      () => RequestOtpWithEmailUseCase(
        forgotPasswordRepository: serviceLocator(),
      ),
    )
    ..registerFactory(() => ChangePasswordUseCase(serviceLocator()));
}

void _createTransactionPin() {
  serviceLocator
    ..registerFactory<CreatePinRemoteDataSource>(
      () => CreatePinRemoteDataSourceImpl(apiClient: serviceLocator()),
    )
    // Repositories
    ..registerFactory<CreatePinRepository>(
      () =>
          CreatePinRepositoryImpl(createPinRemoteDataSource: serviceLocator()),
    )
    // Usecases
    ..registerFactory(
      () => CreatePinUseCase(createPinRepository: serviceLocator()),
    );
}

void _login() {
  serviceLocator
    ..registerFactory<LoginLocalDataSource>(
      () => LoginLocalDataSourceImpl(serviceLocator<SharedPreferences>()),
    )
    ..registerFactory<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImpl(
        authClient: serviceLocator(),
        fingerprint: serviceLocator(),
      ),
    )
    // Repositories
    ..registerFactory<LoginRepository>(
      () => LoginRepositoryImpl(
        loginLocalDataSource: serviceLocator(),
        loginRemoteDataSource: serviceLocator(),
        tokenRepository: serviceLocator(),
        networkInfo: serviceLocator(),
      ),
    )
    // Usecases
    ..registerFactory(() => LoginUseCase(serviceLocator<LoginRepository>()))
    ..registerFactory(
      () => LoginWithBiometricUseCase(
        loginRepository: serviceLocator<LoginRepository>(),
      ),
    )
    ..registerFactory(
      () => DetermineLoginFlowUseCase(
        tokenRepository: serviceLocator<TokenRepository>(),
      ),
    );
}

void _register() {
  serviceLocator
    ..registerFactory<RegisterRemoteDataSource>(
      () => RegisterRemoteDataSourceImpl(
        apiClient: serviceLocator(),
        fingerprint: serviceLocator(),
      ),
    )
    // Repositories
    ..registerFactory<RegisterRepository>(
      () => RegisterRepositoryImpl(
        registerRemoteDataSource: serviceLocator(),
        loginLocalDataSource: serviceLocator(),
        tokenRepository: serviceLocator(),
      ),
    )
    // Usecases
    ..registerFactory(
      () => RegisterUseCase(
        registerRepository: serviceLocator<RegisterRepository>(),
      ),
    );
}

void _airtime() {
  // Datasources
  serviceLocator
    ..registerFactory<AirtimeRemoteDataSource>(
      () =>
          AirtimeRemoteDataSourceImpl(authClient: serviceLocator<AuthClient>()),
    )
    // Repositories
    ..registerFactory<AirtimeRepository>(
      () => AirtimeRepositoryImpl(
        remoteDataSource: serviceLocator<AirtimeRemoteDataSource>(),
        apiErrorHandler: serviceLocator(),
      ),
    )
    // Usecases
    ..registerFactory(
      () => AirtimeUsecase(repository: serviceLocator<AirtimeRepository>()),
    );
}

void _cable() {
  // Datasources
  serviceLocator
    ..registerFactory<CableRemoteDataSource>(
      () => CableRemoteDataSourceImpl(authClient: serviceLocator<AuthClient>()),
    )
    // Repositories
    ..registerFactory<CableRepository>(
      () => CableRepositoryImpl(
        cableRemoteDataSource: serviceLocator<CableRemoteDataSource>(),
        apiErrorHandler: serviceLocator(),
      ),
    )
    // Usecases
    ..registerFactory(
      () => BuyCableUseCase(repository: serviceLocator<CableRepository>()),
    )
    ..registerFactory(
      () =>
          FetchCablePlanUseCase(repository: serviceLocator<CableRepository>()),
    )
    ..registerFactory(
      () => ValidateCableUsecase(repository: serviceLocator<CableRepository>()),
    );
}
