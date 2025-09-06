import 'package:super_cash/app/init/init.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared/shared.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Dependencies
  await initDependencies();

  // // Firebase
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // // Notification setups
  // NotificationService().initialize();

  // Hydrated bloc
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );
  runApp(App(user: AppUser.anonymous));
}



// Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Cool Card',
//                 style: TextStyle(
//                   fontWeight: AppFontWeight.bold,
//                   fontSize: AppSpacing.md,
//                   color: AppColors.white,
//                 ),
//               ),
//               SizedBox.square(
//                 dimension: 36,
//                 child: Assets.images.sim.image(),
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 cardNumbers(cardDetails!.cardNumber),
//                 style: GoogleFonts.exo(
//                   color: AppColors.white,
//                   fontWeight: AppFontWeight.bold,
//                   fontSize: AppSpacing.lg,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 8.0),
//                 child: SizedBox(
//                   child: Assets.icons.wifi.svg(width: 31, height: 32),
//                 ),
//               ),
//             ],
//           ),
//           // Gap.v(AppSpacing.xs),
//           // Row(
//           //   children: [
//           //     _cardMiniText(
//           //       title: 'Total Balance',
//           //       subtitle: cardDetails!.formattedBalance,
//           //     ),
//           //     Spacer(),
//           //     _cardMiniText(
//           //       title: 'Available Balance',
//           //       subtitle: cardDetails!.formattedAvailableBalance,
//           //     ),
//           //     Spacer(),
//           //   ],
//           // ),
//           Gap.v(AppSpacing.lg),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               _cardMiniText(
//                 title: 'Card Name',
//                 subtitle: cardDetails!.cardName,
//               ),
//               _cardMiniText(
//                 title: 'Exp. Date',
//                 subtitle: cardDetails!.formattedExpiryDate,
//               ),
//               _cardMiniText(
//                 title: 'CVV',
//                 subtitle: cardDetails!.cvv,
//               ),
//               Assets.images.international.image(width: 39.92, height: 30)
//             ],
//           ),
//         ],
//       )