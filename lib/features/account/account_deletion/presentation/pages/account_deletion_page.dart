import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/app/view/view.dart';
import 'package:super_cash/features/account/account_deletion/account_deletion.dart';

class AccountDeletionPage extends StatelessWidget {
  const AccountDeletionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AccountDeletionCubit(
        accountDeletionRequestedUseCase: AccountDeletionRequestedUseCase(
          accountDeletionRepository: AccountDeletionRepositoryImpl(
            accountDeletionRemoteDataSource:
                AccountDeletionRemoteDataSourceImpl(
              apiClient: serviceLocator(),
            ),
            apiErrorHandler: serviceLocator(),
          ),
        ),
      ),
      child: const AccountDeletionView(),
    );
  }
}

class AccountDeletionView extends StatelessWidget {
  const AccountDeletionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountDeletionCubit, AccountDeletionState>(
      listenWhen: (previous, current) =>
          previous.status != current.status ||
          previous.message != current.message,
      listener: (context, state) {
        if (state.status.isFailure && state.message.isNotEmpty) {
          openSnackbar(
            SnackbarMessage.error(title: state.message),
            clearIfQueue: true,
          );
        }
        if (state.status.isSuccess && state.message.isNotEmpty) {
          context.showConfirmationBottomSheet(
            title: 'Account deactivated',
            okText: 'Got it',
            description: state.message,
          );
        }
      },
      child: AppScaffold(
        releaseFocus: true,
        appBar: AppBar(
          title: const AppAppBarTitle('Delete account'),
          leading: AppLeadingAppBarWidget(onTap: () => Navigator.pop(context)),
        ),
        body: AppConstrainedScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.xlg,
              children: const [
                _DeletionHero(),
                _RetentionCard(),
                _ReasonField(),
                _DeletionCTA(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DeletionHero extends StatelessWidget {
  const _DeletionHero();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            colorScheme.errorContainer.withValues(alpha: 0.9),
            AppColors.red.withValues(alpha: 0.9),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.red.withValues(alpha: 0.2),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.sm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                ),
                child: const Icon(
                  Icons.shield_moon_rounded,
                  color: Colors.white,
                  size: 26,
                ),
              ),
              Gap.h(AppSpacing.md),
              Text(
                'Deactivate & delete',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: AppFontWeight.semiBold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const Text(
            'We will deactivate your account today and start a 90-day countdown '
            'before permanently erasing your details from our systems.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              height: 1.5,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: AppSpacing.sm),
            padding: EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: const [
                Icon(
                  Icons.error_outline,
                  color: Colors.white,
                  size: 20,
                ),
                Gap.h(AppSpacing.sm),
                Expanded(
                  child: Text(
                    'Changed your mind? Talk to us within those 90 days and we can reactivate your account.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RetentionCard extends StatelessWidget {
  const _RetentionCard();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.md,
        children: [
          Row(
            children: [
              const Icon(
                Icons.auto_awesome,
                color: AppColors.emphasizeGrey,
              ),
              Gap.h(AppSpacing.sm),
              Text(
                'Before you go',
                style: context.titleMedium,
              ),
            ],
          ),
          const Text(
            'This is a sensitive action. We’ll keep your account safely inactive, and permanently remove all data after 90 days.',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.emphasizeGrey,
              height: 1.4,
            ),
          ),
          Column(
            spacing: AppSpacing.sm,
            children: const [
              _InfoRow(
                icon: Icons.safety_check_rounded,
                text: 'Your wallet, cards and history will be paused immediately.',
              ),
              _InfoRow(
                icon: Icons.timer_outlined,
                text:
                    'After 90 days, we permanently delete your details from our database.',
              ),
              _InfoRow(
                icon: Icons.support_agent_outlined,
                text:
                    'Need to return? Reach out during the countdown to reactivate.',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 18,
          color: Theme.of(context).colorScheme.primary,
        ),
        Gap.h(AppSpacing.sm),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

class _ReasonField extends StatefulWidget {
  const _ReasonField();

  @override
  State<_ReasonField> createState() => _ReasonFieldState();
}

class _ReasonFieldState extends State<_ReasonField> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode()
      ..addListener(() {
        if (!_focusNode.hasFocus) {
          context.read<AccountDeletionCubit>().validateReason();
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reasonError = context.select(
      (AccountDeletionCubit cubit) => cubit.state.reasonError,
    );
    final isLoading = context.select(
      (AccountDeletionCubit cubit) => cubit.state.status.isLoading,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.sm,
      children: [
        Text(
          'Why are you leaving?',
          style: TextStyle(
            fontSize: AppSpacing.md,
            fontWeight: FontWeight.w600,
          ),
        ),
        AppTextField.underlineBorder(
          hintText:
              'Share a brief reason so we can serve you better next time.',
          focusNode: _focusNode,
          enabled: !isLoading,
          textController: _controller,
          maxLines: 4,
          minLines: 3,
          textInputAction: TextInputAction.newline,
          prefixIcon: const Icon(
            Icons.chat_bubble_outline,
            color: AppColors.grey,
          ),
          errorText: reasonError,
          onChanged: (value) =>
              context.read<AccountDeletionCubit>().onReasonChanged(value),
        ),
        const Text(
          'This won’t be shared. It simply helps us understand what to fix.',
          style: TextStyle(
            fontSize: 12,
            color: AppColors.emphasizeGrey,
          ),
        ),
      ],
    );
  }
}

class _DeletionCTA extends StatelessWidget {
  const _DeletionCTA();

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (AccountDeletionCubit cubit) => cubit.state.status.isLoading,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: AppSpacing.md,
      children: [
        PrimaryButton(
          isLoading: isLoading,
          backgroundColor: AppColors.red,
          label: 'Deactivate now',
          onPressed: isLoading ? null : () => _confirmDeletion(context),
        ),
        AppOutlinedButton(
          isLoading: false,
          label: 'Keep my account',
          onPressed: isLoading ? null : () => Navigator.pop(context),
        ),
      ],
    );
  }

  Future<void> _confirmDeletion(BuildContext context) {
    final cubit = context.read<AccountDeletionCubit>();
    if (!cubit.validateReason()) {
      openSnackbar(
        SnackbarMessage.error(
          title: 'Please provide a quick reason before continuing.',
        ),
        clearIfQueue: true,
      );
      return Future.value();
    }

    return context.confirmAction(
      fn: () => cubit.submit(),
      title: 'Confirm account deletion',
      content:
          'We will deactivate your account immediately. After 90 days your data is wiped. You can contact us anytime before then to reactivate.',
      noText: 'Cancel',
      yesText: 'Yes, delete it',
      
    );
  }
}
