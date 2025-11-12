import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app_strings/app_string.dart';
import '../../../widgets/assistance_button.dart';
import '../../verify.dart';

class VerifyPage extends StatelessWidget {
  const VerifyPage({super.key, required this.email});
  final String email;

  static Route<void> route({required String email}) => PageRouteBuilder(
    pageBuilder: (_, __, ___) => VerifyPage(email: email),
    transitionDuration: Duration.zero,
    reverseTransitionDuration: Duration.zero,
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerifyCubit(
        otpUseCase: serviceLocator<OtpUseCase>(),
        email: email,
        requestVerifyOtpUseCase: serviceLocator<RequestVerifyOtpUseCase>(),
      ),
      child: VerifyView(),
    );
  }
}

class VerifyView extends StatefulWidget {
  const VerifyView({super.key});

  @override
  State<VerifyView> createState() => _VerifyViewState();
}

class _VerifyViewState extends State<VerifyView> {
  void _confirmGoBack(BuildContext context) => context.confirmAction(
    fn: () => Navigator.pop(context),
    title: AppStrings.goBackTitle,
    content: AppStrings.goBackDescrption,
    noText: AppStrings.cancel,
    yesText: AppStrings.goBack,
    yesTextStyle: context.labelLarge?.apply(color: AppColors.blue),
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VerifyCubit>().requestOtp();
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () {
        _confirmGoBack(context);
        return Future.value(false);
      },
      child: AppScaffold(
        releaseFocus: true,
        resizeToAvoidBottomInset: true,
        appBar: _appBar(context),
        body: AppConstrainedScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Column(
              spacing: AppSpacing.lg,
              children: [
                VeriifyContainerInfo(email: ''),
                Gap.v(AppSpacing.xxlg),
                VerifyOtpForm(),
                Gap.v(AppSpacing.spaceUnit),
                Text(
                  'Resend code in 0:44 sec',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: AppFontWeight.bold,
                  ),
                ),
                Gap.v(AppSpacing.xxxlg),
                VerifyOtpButton(),
                AssistanceButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: AppLeadingAppBarWidget(onTap: () => _confirmGoBack(context)),
      title: const Text(
        AppStrings.verifyAccount,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
    );
  }
}
