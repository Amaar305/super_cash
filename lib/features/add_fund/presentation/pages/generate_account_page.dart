import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/app.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/config.dart';
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/core/common/widgets/app_prefix_icon.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';

import '../../add_fund.dart';

class GenerateAccountPage extends StatelessWidget {
  GenerateAccountPage({super.key});

  final AddFundCubit _cubit = AddFundCubit(
    generateAccountUseCase: serviceLocator(),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: _cubit, child: GenerateAccountView());
  }
}

class GenerateAccountView extends StatelessWidget {
  const GenerateAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      releaseFocus: true,
      appBar: AppBar(
        title: const Text('Generate Account'),
        leading: AppLeadingAppBarWidget(onTap: context.pop),
      ),
      body: AppConstrainedScrollView(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.xlg,
          children: [
            Column(
              spacing: AppSpacing.lg,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [GenerateAccountCBNINFO(), GenerateAccountForm()],
            ),
            Gap.v(AppSpacing.lg),
            GenerateAccountButton(),
          ],
        ),
      ),
    );
  }
}

class GenerateAccountButton extends StatelessWidget {
  const GenerateAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (AddFundCubit cubit) => cubit.state.status.isLoading,
    );
    return PrimaryButton(
      isLoading: isLoading,
      onPressed: () {
        context.read<AddFundCubit>().generateAccount((message) {
          context.showConfirmationBottomSheet(
            title: 'Accounts Generated Successfully',
            okText: 'Done',
            description: message,
          );
          // context.pop();
        });
      },
      label: 'Generate Account',
    );
  }
}

class GenerateAccountForm extends StatelessWidget {
  const GenerateAccountForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddFundCubit, AddFundState>(
      listenWhen: (previous, current) =>
          previous.status != current.status ||
          previous.message != current.message,
      listener: (context, state) {
        if (state.status.isFailure && state.message.isNotEmpty) {
          openSnackbar(
            SnackbarMessage.error(title: state.message),
            clearIfQueue: true,
          );
          return;
        }
      },
      child: GenerateAccountBvnField(),
    );
  }
}

class GenerateAccountBvnField extends StatefulWidget {
  const GenerateAccountBvnField({super.key});

  @override
  State<GenerateAccountBvnField> createState() =>
      _GenerateAccountBvnFieldState();
}

class _GenerateAccountBvnFieldState extends State<GenerateAccountBvnField> {
  late final AddFundCubit _cubit;
  late final Debouncer _debouncer;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<AddFundCubit>();
    _debouncer = Debouncer();
    _focusNode = FocusNode()
      ..addListener(() {
        if (!_focusNode.hasFocus) {
          _cubit.onBvnUnfocused();
        }
      });
  }

  @override
  void dispose() {
    _debouncer.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (AddFundCubit element) => element.state.status.isLoading,
    );
    final bvnErrMsg = context.select(
      (AddFundCubit element) => element.state.bvn.errorMessage,
    );
    return Column(
      spacing: AppSpacing.lg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          // AppStrings.bvnNumber
          'Enter your bvn to generate an account',
          style: poppinsTextStyle(
            fontSize: AppSpacing.md - 1,
            fontWeight: AppFontWeight.semiBold,
          ),
        ),
        AppTextField.underlineBorder(
          enabled: !isLoading,
          errorText: bvnErrMsg,
          onChanged: (value) =>
              _debouncer.run(() => _cubit.onBvnChanged(value)),
          focusNode: _focusNode,
          filled: Config.filled,
          prefixIcon: AppPrefixIcon(Icons.verified_user_outlined),
          textInputType: TextInputType.number,
          textInputAction: TextInputAction.done,
          hintText: "Enter ${AppStrings.bvnNumber.toLowerCase()}",
        ),
      ],
    );
  }
}

class GenerateAccountCBNINFO extends StatelessWidget {
  const GenerateAccountCBNINFO({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md + 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.blue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        'As per CBN regulations, you must provide your BVN to generate some accounts.',
        textAlign: TextAlign.center,
        style: poppinsTextStyle(
          fontSize: AppSpacing.md,
          fontWeight: AppFontWeight.light,
        ),
      ),
    );
  }
}
