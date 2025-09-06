import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/features/account/change_password/change_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordCubit(
        changePasswordUseCase: ChangePasswordUseCase(
          changePasswordRepository: ChangePasswordRepositoryImpl(
            changePasswordRemoteDataSource: ChangePasswordRemoteDataSourceImpl(
              apiClient: serviceLocator(),
            ),
            apiErrorHandler: serviceLocator(),
          ),
        ),
      ),
      child: ChangePasswordView(),
    );
  }
}

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      releaseFocus: true,
      appBar: AppBar(
        title: AppAppBarTitle(AppStrings.changePassword),
        leading: AppLeadingAppBarWidget(onTap: () => Navigator.pop(context)),
      ),
      body: AppConstrainedScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              ChangePasswordForm(),
              Gap.v(AppSpacing.xxxlg),
              ChangePasswordButton(),
            ],
          ),
        ),
      ),
    );
  }
}
