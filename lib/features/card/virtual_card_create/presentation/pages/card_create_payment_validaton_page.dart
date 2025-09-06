// import 'package:app_ui/app_ui.dart';
// import 'package:super_cash/core/app_strings/app_string.dart';
// import 'package:super_cash/features/card/widgets/card_detail_container.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../virtual_card_create.dart';

// class CardCreatePaymentValidatonPage extends StatelessWidget {
//   const CardCreatePaymentValidatonPage({super.key, required this.cardCubit});

//   final CreateVirtualCardCubit cardCubit;

//   static route({required CreateVirtualCardCubit cardCubit}) =>
//       MaterialPageRoute(
//         builder: (context) => CardCreatePaymentValidatonPage(
//           cardCubit: cardCubit,
//         ),
//       );

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider.value(
//       value: cardCubit,
//       child: CardCreatePaymentValidationView(),
//     );
//   }
// }

// class CardCreatePaymentValidationView extends StatelessWidget {
//   const CardCreatePaymentValidationView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AppScaffold(
//       appBar: AppBar(
//         leading: AppLeadingAppBarWidget(),
//         title: AppAppBarTitle(AppStrings.cardPaymentValidation),
//       ),
//       body: AppScaffold(
//         body: AppConstrainedScrollView(
//           child: Padding(
//             padding: EdgeInsets.all(AppSpacing.lg),
//             child: Column(
//               spacing: AppSpacing.xlg,
//               children: [
//                 VeryPurchaseWidget(),
//                 CardDetailContainer(
//                   text: 'Total Amount to Pay: ',
//                   text2: '31 - N4,590',
//                 ),
//                 AppPinForm(
//                   onCompleted: (p0) {
//                     context.showConfirmationBottomSheet(
//                       title: 'Card Created Successfully!',
//                       description:
//                           'The MasterCard USD Card was created sucessfully.',
//                       okText: 'Done',
//                     );
//                   },
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
