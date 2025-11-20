import 'dart:async';

import 'package:animations/animations.dart';
import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/cubit/app_cubit.dart';
import 'package:super_cash/features/account/account.dart';
import 'package:super_cash/features/account/change_password/change_password.dart';
import 'package:super_cash/features/add_fund/add_fund.dart';
import 'package:super_cash/features/auth/referral_type/referral_type.dart';
import 'package:super_cash/features/bonus/presentation/presentation.dart';
import 'package:super_cash/features/confirm_transaction_pin/confirm_transaction_pin.dart';
import 'package:super_cash/features/onboarding/onboarding.dart';
import 'package:super_cash/features/referal/referal.dart';
import 'package:super_cash/features/transfer/presentation/pages/transfer_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/features/welcome/welcome.dart';

import '../../features/auth/auth.dart';
import '../../features/card/card.dart';
import '../../features/enable_biometric/enable_biometric.dart';
import '../../features/history/history.dart';
import '../../features/home/home.dart';
import '../../features/index/index.dart';
import '../../features/live_chat/live_chat.dart';
import '../../features/notification/notification.dart';
import '../../features/splash/splash.dart';
import '../../features/upgrade_tier/upgrade_tier.dart';
import '../../features/vtupass/vtupass.dart';
import '../app.dart';
import '../bloc/app_bloc.dart';

// app_router.dart
final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

class AppRouter {
  const AppRouter(this.appBloc, this.app);
  final AppBloc appBloc;
  final AppCubit app;
  static bool _sessionExpiredOverlayVisible = false;

  GoRouter get router => GoRouter(
    initialLocation: AppRoutes.splash,
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    errorBuilder: (context, state) => const NotFoundPage(),

    routes: [
      GoRoute(
        name: RNames.splash,
        path: AppRoutes.splash,
        builder: (context, state) => SplashPage(),
      ),
      GoRoute(
        name: RNames.onboarding,
        path: AppRoutes.onboarding,
        builder: (context, state) => OnboardingPage(),
      ),
      GoRoute(
        name: RNames.welcome,
        path: AppRoutes.welcome,
        builder: (context, state) => WelcomePage(),
      ),
      GoRoute(
        name: RNames.enableBiometric,
        path: AppRoutes.enableBiometric,
        builder: (context, state) => EnableBiometricPage(user: app.state.user!),
      ),
      GoRoute(
        name: RNames.upgradeTier,
        path: AppRoutes.upgradeTier,
        builder: (context, state) => UpgradeTierPage(),
      ),
      GoRoute(
        name: RNames.addFunds,
        path: AppRoutes.addFunds,
        builder: (context, state) => AddFundPage(),
      ),
      GoRoute(
        name: RNames.auth,
        path: AppRoutes.auth,
        builder: (context, state) => AuthPage(islogin: app.state.showLogin),
      ),
      GoRoute(
        name: RNames.verifyAccount,
        path: AppRoutes.verifyAccount,
        builder: (context, state) => VerifyPage(email: app.state.user!.email),
      ),

      GoRoute(
        path: AppRoutes.createPin,
        name: RNames.createPin,
        builder: (context, state) {
          return CreatePinPage();
        },
      ),

      GoRoute(
        name: RNames.referralType,
        path: AppRoutes.referralType,
        builder: (context, state) => ReferralTypePage(),
      ),

      GoRoute(
        name: RNames.notifications,
        path: AppRoutes.notifications,
        builder: (context, state) => NotificationPage(),
      ),
      GoRoute(
        name: RNames.airtime,
        path: AppRoutes.airtime,
        builder: (context, state) => AirtimePage(),
        routes: [
          GoRoute(
            name: RNames.airtimeConfirm,
            path: 'airtime-confirm',
            builder: (context, state) => AirtmeConfirmPage(),
          ),
        ],
      ),
      GoRoute(
        name: RNames.data,
        path: AppRoutes.data,
        builder: (_, __) => DataPage(),
      ),
      GoRoute(
        name: RNames.cable,
        path: AppRoutes.cable,
        builder: (_, __) => CablePage(),
      ),
      GoRoute(
        name: RNames.electricity,
        path: AppRoutes.electricity,
        builder: (_, __) => ElectricityPage(),
      ),
      GoRoute(
        name: RNames.transactionDetail,
        path: AppRoutes.transactionDetail,
        builder: (context, state) =>
            HistoryDetailsPage(transaction: state.extra as TransactionResponse),
      ),
      GoRoute(
        name: RNames.referFriend,
        path: AppRoutes.referFriend,
        builder: (context, state) => ReferralPage(),
        routes: [
          GoRoute(
            name: RNames.referHowItWorks,
            path: 'refer-how-it-works',
            builder: (context, state) => HowItWorkPage(),
          ),
        ],
      ),
      GoRoute(
        name: RNames.examPin,
        path: AppRoutes.examPin,
        builder: (_, __) => ExamPinPage(),
      ),
      GoRoute(
        name: RNames.smile,
        path: AppRoutes.smile,
        builder: (_, __) => SmilePage(),
        routes: [
          GoRoute(
            name: RNames.smileProceed,
            path: 'smile-proceed',
            builder: (context, state) =>
                SmileProceedPage(cubit: state.extra as SmileCubit),
          ),
        ],
      ),
      GoRoute(
        name: RNames.manageBeneficiary,
        path: AppRoutes.manageBeneficiary,
        builder: (_, __) => ManageBeneficiaryPage(),
        routes: [
          GoRoute(
            name: RNames.saveBeneficiary,
            path: 'save',
            builder: (context, state) =>
                SaveBeneficiaryPage(beneficiary: state.extra as Beneficiary?),
          ),
        ],
      ),
      GoRoute(
        name: RNames.confirmationDialog,
        path: AppRoutes.confirmationDialog,
        pageBuilder: (context, state) => MaterialPage(
          fullscreenDialog: true,
          child: ConfirmTransactionPinPage(
            transactionPurchaseDetail: state.extra as Widget?,
          ),
        ),
      ),
      GoRoute(
        name: RNames.virtualCard,
        path: AppRoutes.virtualCard,
        builder: (_, __) => VirtualCardPage(),
        routes: [
          GoRoute(
            name: RNames.virtualCardCreate,
            path: 'create',
            builder: (_, __) => CardCreatePage(),
          ),
          GoRoute(
            name: RNames.virtualCardFund,
            path: 'fund',
            builder: (context, state) =>
                FundCardPage(cardId: state.extra as String),
          ),
          GoRoute(
            name: RNames.virtualCardDetail,
            path: 'detail',
            builder: (context, state) =>
                CardDetailsPage(cardId: state.extra as String),
            routes: [
              GoRoute(
                name: RNames.virtualCardChangePin,
                path: 'change-pin',
                builder: (context, state) {
                  final extras = state.extra as Map<String, dynamic>;
                  final cardId = extras['card_id'] as String;
                  final cardDetails = extras['card_details'];
                  return ChangeCardPinPage(cardId: cardId, card: cardDetails);
                },
              ),
            ],
          ),
          GoRoute(
            name: RNames.virtualCardWithdraw,
            path: 'card-withdraw',
            builder: (context, state) =>
                CardWithdrawPage(cardId: state.extra as String),
          ),
          GoRoute(
            name: RNames.virtualCardTransactions,
            path: 'card-transactions',
            builder: (context, state) =>
                CardTransactionPage(cardId: state.extra as String),
          ),
        ],
      ),
      GoRoute(
        name: RNames.transfer,
        path: AppRoutes.transfer,
        builder: (_, __) => TransferPage(),
      ),
      GoRoute(
        name: RNames.generateAccount,
        path: AppRoutes.generateAccount,
        builder: (_, __) => GenerateAccountPage(),
      ),
      GoRoute(
        name: RNames.changePassword,
        path: AppRoutes.changePassword,
        builder: (_, __) => ChangePasswordPage(),
      ),
      GoRoute(
        name: RNames.bonus,
        path: AppRoutes.bonus,
        builder: (_, __) => BonusPage(),
      ),

      // ---- Shell (tabs) ----
      StatefulShellRoute.indexedStack(
        builder: (context, state, nav) => IndexPage(navigationShell: nav),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: RNames.dashboard,
                path: AppRoutes.dashboard,
                pageBuilder: (context, state) => CustomTransitionPage(
                  child: HomePage(),
                  transitionsBuilder: (context, a, sa, child) =>
                      SharedAxisTransition(
                        animation: a,
                        secondaryAnimation: sa,
                        transitionType: SharedAxisTransitionType.horizontal,
                        child: child,
                      ),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: RNames.history,
                path: AppRoutes.history,
                pageBuilder: (context, state) => CustomTransitionPage(
                  child: HistoryPage(),
                  transitionsBuilder: (context, a, sa, child) => FadeTransition(
                    opacity: CurvedAnimation(
                      parent: a,
                      curve: Curves.easeInOut,
                    ),
                    child: child,
                  ),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: RNames.liveChat,
                path: AppRoutes.liveChat,
                pageBuilder: (context, state) => CustomTransitionPage(
                  child: LiveChatPage(),
                  transitionsBuilder: (context, a, sa, child) =>
                      SharedAxisTransition(
                        animation: a,
                        secondaryAnimation: sa,
                        transitionType: SharedAxisTransitionType.horizontal,
                        child: child,
                      ),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: RNames.profile,
                path: AppRoutes.profile,
                pageBuilder: (context, state) => CustomTransitionPage(
                  child: ProfilePage(userId: 'amarr'),
                  transitionsBuilder: (context, a, sa, child) =>
                      SharedAxisTransition(
                        animation: a,
                        secondaryAnimation: sa,
                        transitionType: SharedAxisTransitionType.horizontal,
                        child: child,
                      ),
                ),
                routes: [
                  GoRoute(
                    name: RNames.profileDetails,
                    path: 'profile-details',
                    builder: (_, __) => ProfileDetailPage(),
                  ),
                  GoRoute(
                    name: RNames.manageTransactionPin,
                    path: 'manage-transaction-pin',
                    builder: (_, __) => ManageTransactionPinPage(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],

    // Same hardened redirect you tested; returns only absolute non-empty paths or null.
    redirect: guardRedirect,

    //  (context, state) {
    //   final status = appBloc.state.status;
    //   final onboarded = launch.onboarded;
    //   final welcome = launch.welcomePending;
    //   final current = state.matchedLocation.isEmpty
    //       ? AppRoutes.splash
    //       : state.matchedLocation;

    //   String? goIfDifferent(String target) => current == target ? null : target;

    //   if (onboarded == null) return goIfDifferent(AppRoutes.splash);
    //   if (onboarded == false) return goIfDifferent(AppRoutes.onboarding);
    //   if (welcome) return goIfDifferent(AppRoutes.welcome);

    //   switch (status) {
    //     case AppStatus.unknown:
    //       return goIfDifferent(AppRoutes.splash);
    //     case AppStatus.unauthenticated:
    //     case AppStatus.resumed:
    //       if ([
    //         AppRoutes.auth,
    //         AppRoutes.onboarding,
    //         AppRoutes.welcome,
    //       ].contains(current)) {
    //         return null;
    //       }
    //       return goIfDifferent(AppRoutes.auth);
    //     case AppStatus.authenticated:
    //     case AppStatus.updated:
    //       if ([
    //         AppRoutes.splash,
    //         AppRoutes.auth,
    //         AppRoutes.onboarding,
    //         AppRoutes.welcome,
    //       ].contains(current)) {
    //         return goIfDifferent(AppRoutes.dashboard);
    //       }
    //       return null;
    //   }
    // },
    refreshListenable: GoRouterAppBlocRefreshStream(app.stream),
  );

  String? guardRedirect(BuildContext context, GoRouterState s) {
    final st = app.state.status;
    final loc = s.matchedLocation.isEmpty
        ? AppRoutes.splash
        : s.matchedLocation;

    bool at(String path) => loc == path || loc.startsWith("$path/");
    String? go(String path) => at(path) ? null : path;

    final bool isLoggingIn = at(AppRoutes.auth);

    // logI('logged In $loggedIn');
    // logI('is Logging In $isLoggingIn');

    switch (st) {
      case AppStatus2.initial:
      case AppStatus2.splash:
        return go(AppRoutes.splash);
      case AppStatus2.onboarding:
        return go(AppRoutes.onboarding);
      case AppStatus2.welcome:
        return go(AppRoutes.welcome);
      case AppStatus2.unauthenticated:
        return go(AppRoutes.auth);

      case AppStatus2.createPin:
        return go(AppRoutes.createPin);
      case AppStatus2.verifyAccount:
        return go(AppRoutes.verifyAccount);
      case AppStatus2.referralType:
        return go(AppRoutes.referralType);
      case AppStatus2.authenticated:
        const blocked = <String>{
          AppRoutes.splash,
          AppRoutes.onboarding,
          AppRoutes.welcome,
          AppRoutes.auth,
          AppRoutes.createPin,
          AppRoutes.referralType,
          AppRoutes.enableBiometric,
          AppRoutes.verifyAccount,
        };
        if (blocked.any(at)) {
          return AppRoutes.dashboard;
        }
        return null;
      case AppStatus2.tokenExpired:
        if (isLoggingIn) return null;
        if (!_sessionExpiredOverlayVisible) {
          final navigatorContext = _rootNavigatorKey.currentContext;
          if (navigatorContext != null) {
            _sessionExpiredOverlayVisible = true;
            unawaited(
              AppSessionExpiredOverlay.show(
                navigatorContext,
                onPrimaryPressed: () {
                  app.userStarted(true);
                },
              ).whenComplete(() {
                _sessionExpiredOverlayVisible = false;
              }),
            );
          }
        }

        return null;
      case AppStatus2.enableBiometric:
        return null;
    }
  }
}

class GoRouterAppBlocRefreshStream extends ChangeNotifier {
  GoRouterAppBlocRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((event) {
      notifyListeners();
    });
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

extension NavX on BuildContext {
  FutureOr<Null> goNamedSafe(
    String name, {
    Map<String, String>? pathParams,
    Map<String, String>? queryParams,
    Object? extra,
  }) {
    if (name.isEmpty) Null;
    return pushNamed(
      name,
      pathParameters: pathParams ?? const {},
      queryParameters: queryParams ?? const {},
      extra: extra,
    );
  }
}
