import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/core/common/common.dart';
import 'package:super_cash/features/referal/referal.dart';

class ReferralListType extends StatelessWidget {
  const ReferralListType({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ReferalCubit>();
    final type = context.select(
      (ReferalCubit element) => element.state.showReferralList,
    );
    return AppTab(
      backgroundColor: AppColors.brightGrey,
      children: [
        AppTabItem(
          label: 'Referral List',
          activeTab: type,
          activeColor: Color(0xff12213A),
          activeTextColor: AppColors.white,
          onTap: () => cubit.changeReferralType(true),
        ),
        AppTabItem(
          label: 'Invitees',
          activeColor: Color(0xff12213A),
          activeTab: !type,
          onTap: () => cubit.changeReferralType(false),
          activeTextColor: AppColors.white,
        ),
      ],
    );
  }
}
