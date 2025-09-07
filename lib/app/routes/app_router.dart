import 'dart:async';

import 'package:animations/animations.dart';
import 'package:super_cash/features/account/account.dart';
import 'package:super_cash/features/account/change_password/change_password.dart';
import 'package:super_cash/features/add_fund/add_fund.dart';
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

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

class AppRouter {
  const AppRouter(this.appBloc, this.launch);

  final AppBloc appBloc;
  final LaunchState launch;

  GoRouter get router => GoRouter(
    initialLocation: AppRoutes.dashboard,
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => OnboardingPage(),
      ),
      GoRoute(
        path: AppRoutes.welcome,
        builder: (context, state) => WelcomePage(),
      ),
      GoRoute(
        path: AppRoutes.enableBiometric,
        builder: (context, state) {
          final user = state.extra! as AppUser;

          return EnableBiometricPage(user: user);
        },
      ),
      GoRoute(
        path: AppRoutes.upgradeTier,
        builder: (context, state) => UpgradeTierPage(),
      ),
      GoRoute(
        path: AppRoutes.addFunds,
        builder: (context, state) => AddFundPage(),
      ),
      GoRoute(
        path: AppRoutes.auth,
        builder: (context, state) => AuthPage(islogin: launch.isLoginPage),
      ),
      GoRoute(
        path: AppRoutes.notifications,
        builder: (context, state) => NotificationPage(),
      ),
      GoRoute(
        path: AppRoutes.airtime,
        builder: (context, state) => AirtimePage(),
      ),
      GoRoute(
        path: AppRoutes.airtimeConfirm,
        name: AppRoutes.airtimeConfirm,
        builder: (context, state) => AirtmeConfirmPage(),
      ),
      GoRoute(path: AppRoutes.data, builder: (context, state) => DataPage()),
      GoRoute(path: AppRoutes.cable, builder: (context, state) => CablePage()),
      GoRoute(
        path: AppRoutes.transacttionDetail,
        builder: (context, state) {
          final transaction = state.extra as TransactionResponse;
          return HistoryDetailsPage(transaction: transaction);
        },
      ),
      GoRoute(
        path: AppRoutes.electricity,
        builder: (context, state) => ElectricityPage(),
      ),
      GoRoute(
        path: AppRoutes.referFriend,
        builder: (context, state) => ReferralPage(),
      ),
      GoRoute(
        path: AppRoutes.examPin,
        builder: (context, state) => ExamPinPage(),
      ),
      GoRoute(
        path: AppRoutes.smile,
        builder: (context, state) => SmilePage(),
        routes: [
          GoRoute(
            path: 'smile-proceed',
            builder: (context, state) {
              final cubit = state.extra as SmileCubit;
              return SmileProceedPage(cubit: cubit);
            },
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.manageBeneficiary,
        builder: (context, state) => ManageBeneficiaryPage(),
        routes: [
          GoRoute(
            path: 'save',
            builder: (context, state) {
              final beneficiary = state.extra as Beneficiary?;
              return SaveBeneficiaryPage(beneficiary: beneficiary);
            },
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.confirmationDialog,
        pageBuilder: (context, state) {
          final result = state.extra as Widget?;
          return MaterialPage(
            fullscreenDialog: true,
            child: ConfirmTransactionPinPage(transactionPurchaseDetail: result),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.virtualCard,
        builder: (context, state) => VirtualCardPage(),
        routes: [
          GoRoute(
            path: 'create',
            builder: (context, state) => CardCreatePage(),
          ),
          GoRoute(
            path: 'fund',
            builder: (context, state) {
              final cardId = state.extra as String;
              return FundCardPage(cardId: cardId);
            },
          ),
          GoRoute(
            path: 'detail',
            builder: (context, state) {
              final cardId = state.extra as String;
              return CardDetailsPage(cardId: cardId);
            },
            routes: [
              GoRoute(
                path: 'change-pin',
                builder: (context, state) {
                  final extras = state.extra as Map<String, dynamic>;

                  final cardId = extras['card_id']!;
                  final cardDetails = extras['card_details'];

                  return ChangeCardPinPage(cardId: cardId, card: cardDetails);
                },
              ),
            ],
          ),
          GoRoute(
            path: 'card-withdraw',
            builder: (context, state) {
              final cardId = state.extra as String;
              return CardWithdrawPage(cardId: cardId);
            },
          ),
          GoRoute(
            path: 'card-transactions',
            builder: (context, state) {
              final cardId = state.extra as String;
              return CardTransactionPage(cardId: cardId);
            },
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.transfer,
        builder: (context, state) => TransferPage(),
      ),
      GoRoute(
        path: AppRoutes.generateAccount,
        builder: (context, state) => GenerateAccountPage(),
      ),
      GoRoute(
        path: AppRoutes.changePassword,
        builder: (context, state) => ChangePasswordPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return IndexPage(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.dashboard,
                pageBuilder: (context, state) {
                  return CustomTransitionPage(
                    child: HomePage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                          return SharedAxisTransition(
                            animation: animation,
                            secondaryAnimation: secondaryAnimation,
                            transitionType: SharedAxisTransitionType.horizontal,
                            child: child,
                          );
                        },
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.history,
                pageBuilder: (context, state) {
                  return CustomTransitionPage(
                    child: HistoryPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: CurveTween(
                              curve: Curves.easeInOut,
                            ).animate(animation),
                            child: child,
                          );
                        },
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/liveChat',
                pageBuilder: (context, state) {
                  return CustomTransitionPage(
                    child: LiveChatPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                          return SharedAxisTransition(
                            animation: animation,
                            secondaryAnimation: secondaryAnimation,
                            transitionType: SharedAxisTransitionType.horizontal,
                            child: child,
                          );
                        },
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                pageBuilder: (context, state) {
                  return CustomTransitionPage(
                    child: ProfilePage(userId: 'amarr'),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                          return SharedAxisTransition(
                            animation: animation,
                            secondaryAnimation: secondaryAnimation,
                            transitionType: SharedAxisTransitionType.horizontal,
                            child: child,
                          );
                        },
                  );
                },
                routes: [
                  GoRoute(
                    path: 'profile-details',
                    builder: (context, state) {
                      return ProfileDetailPage();
                    },
                  ),
                  GoRoute(
                    path: 'manage-transaction-pin',
                    builder: (context, state) {
                      return ManageTransactionPinPage();
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final status = appBloc.state.status;
      final onboarded = launch.onboarded; // null/false/true
      final welcome = launch.welcomePending; // bool

      final loc = state.matchedLocation;
      final isSplash = loc == AppRoutes.splash;
      final isLogin = loc == AppRoutes.auth;
      final isOb = loc == AppRoutes.onboarding;
      final isWel = loc == AppRoutes.welcome;

      // 0) Still loading → Splash
      if (onboarded == null) return isSplash ? null : AppRoutes.splash;

      // 1) Not onboarded → Onboarding
      if (onboarded == false) return isOb ? null : AppRoutes.onboarding;

      // 2) Onboarded and Welcome pending → Welcome
      if (welcome) return isWel ? null : AppRoutes.welcome;

      // 3) Onboarded & Welcome done → auth flow
      if (status == AppStatus.unknown) {
        return isSplash ? null : AppRoutes.splash;
      }
      if (status == AppStatus.unauthenticated || status == AppStatus.resumed) {
        return isLogin ? null : AppRoutes.auth;
      }
      if (status == AppStatus.authenticated) {
        if (isSplash || isLogin || isOb || isWel) return AppRoutes.dashboard;
        return null;
      }

      return null;
    },
    refreshListenable: Listenable.merge([
      GoRouterAppBlocRefreshStream(appBloc.stream),
      launch,
    ]),
  );
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
