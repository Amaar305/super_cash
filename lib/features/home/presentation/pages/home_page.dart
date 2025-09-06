import 'package:app_ui/app_ui.dart';
import 'package:super_cash/features/card/card_repo/cubit/card_repo_cubit.dart';
import 'package:super_cash/features/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CardRepoCubit>().fetchDollarRate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      safeArea: false,
      extendBodyBehindAppBar: true,
      body: DecoratedBox(
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
                    NewWallet(),
                    Gap.v(32),
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
                              children: [
                                SizedBox(height: 75),
                                HomeScrollText(),
                                KYCNoticeBoard(),
                                SizedBox(height: 8),

                                HomeServicesSection(),
                                HomeImageSlider(),
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
    );
  }
}
