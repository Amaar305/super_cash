import 'dart:async';

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/app/view/app.dart';
import 'package:super_cash/core/helper/app_url_launcher.dart';
import 'package:super_cash/features/card/card_repo/cubit/card_repo_cubit.dart';
import 'package:super_cash/features/home/home.dart';
import 'package:super_cash/features/home/presentation/widgets/home_low_wallet_alert.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const _highPriorityThreshold = 20;
  String? _handledUpdateId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      unawaited(context.read<CardRepoCubit>().fetchDollarRate());
      context.read<HomeCubit>().fetchAppSettings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      safeArea: false,
      extendBodyBehindAppBar: true,
      body: BlocListener<HomeCubit, HomeState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status.isLoading) {
            showLoadingOverlay(context);
          } else {
            hideLoadingOverlay();
          }
          final update = state.homeSettings?.appUpdate;
          if (update != null) {
            _maybeShowAppUpdateDialog(context, update);
          }
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.black.withValues(alpha: 0.7), AppColors.black],
            ),
          ),
          child: RefreshIndicator.adaptive(
            onRefresh: () async =>
                context.read<HomeCubit>().onRefresh(forceRefresh: true),
            child: Stack(
              children: [
                SafeArea(
                  top: true,
                  child: ListView(
                    padding: EdgeInsets.only(top: 74, bottom: 16),
                    children: [
                      const NewWallet(),
                      const Gap.v(32),
                      Stack(
                        fit: StackFit.passthrough,
                        clipBehavior: Clip.none,
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: MediaQuery.of(context).size.height,
                            ),
                            child: Material(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                              child: Column(
                                children: const [
                                  Gap.v(75),
                                  HomeLowWalletAlert(),
                                  HomeScrollText(),
                                  HomeImageSlider(),
                                  KYCNoticeBoard(),
                                  HomeServicesSection(),
                                  // HomeRecentTransactionSection(),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: -40,
                            left: 0,
                            right: 0,
                            child: HomeQuickActionSection(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                HomeAppBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _maybeShowAppUpdateDialog(BuildContext context, AppUpdate appUpdate) {
    if (!appUpdate.requiresUpdate) return;
    if (_handledUpdateId == appUpdate.id) return;

    final isCritical =
        appUpdate.forceUpdate && appUpdate.priority >= _highPriorityThreshold;

    _handledUpdateId = appUpdate.id;
    showDialog<void>(
      context: context,
      barrierDismissible: !isCritical,
      barrierColor: Colors.black.withValues(alpha: 0.6),
      // ignore: deprecated_member_use
      builder: (dialogContext) => WillPopScope(
        onWillPop: () async => !isCritical,
        child: AppUpdateDialog(
          appUpdate: appUpdate,
          isCritical: isCritical,
          onUpdateNow: () {
            // _popDialog(dialogContext);
            if (appUpdate.storeUrl.isNotEmpty) {
              launchLink(appUpdate.storeUrl);
            }
          },
          onMaybeLater: isCritical
              ? null
              : () {
                  _popDialog(dialogContext);
                },
        ),
      ),
    );
  }

  void _popDialog(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }
}
